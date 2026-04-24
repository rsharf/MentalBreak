#include "op_multiclass_info.h"
#include "../common/eq_stream.h"
#include "../common/thj_multiclass.h"
#include "../common/packet_functions.h"
#include "../common/emu_versions.h"
#include "client.h"
#include <algorithm>

using namespace THJ;

// helpers you’ll implement against your server model:
static void GatherClasses(Client* c, std::vector<McClass>& out);
static void GatherAAs(Client* c, std::vector<McAA>& out);
static void GatherSpells(Client* c, std::vector<McSpell>& out);
static void GatherSkills(Client* c, std::vector<McSkill>& out);
static void GatherDiscs(Client* c, std::vector<McDisc>& out);
static void GatherAbilities(Client* c, std::vector<McAbility>& out);

static std::vector<uint8_t> Serialize(const MulticlassInfo& hdr,
                                      const std::vector<McClass>& classes,
                                      const std::vector<McAA>& aas,
                                      const std::vector<McSpell>& spells,
                                      const std::vector<McSkill>& skills,
                                      const std::vector<McDisc>& discs,
                                      const std::vector<McAbility>& abilities)
{
    std::vector<uint8_t> buf;
    buf.reserve(64 * 1024);

    auto push = [&](auto const* p, size_t n){
        const uint8_t* b = reinterpret_cast<const uint8_t*>(p);
        buf.insert(buf.end(), b, b + n);
    };

    MulticlassInfo h = hdr;
    h.class_count  = static_cast<uint8_t>(std::min<size_t>(classes.size(), 255));
    h.aa_count     = static_cast<uint16_t>(std::min<size_t>(aas.size(), 65535));
    h.spell_count  = static_cast<uint16_t>(std::min<size_t>(spells.size(), 65535));
    h.skill_count  = static_cast<uint16_t>(std::min<size_t>(skills.size(), 65535));
    h.disc_count   = static_cast<uint16_t>(std::min<size_t>(discs.size(), 65535));
    h.ability_count= static_cast<uint16_t>(std::min<size_t>(abilities.size(), 65535));

    push(&h, sizeof(h));
    if (!classes.empty())  push(classes.data(),  h.class_count  * sizeof(McClass));
    if (!aas.empty())      push(aas.data(),      h.aa_count     * sizeof(McAA));
    if (!spells.empty())   push(spells.data(),   h.spell_count  * sizeof(McSpell));
    if (!skills.empty())   push(skills.data(),   h.skill_count  * sizeof(McSkill));
    if (!discs.empty())    push(discs.data(),    h.disc_count   * sizeof(McDisc));
    if (!abilities.empty())push(abilities.data(),h.ability_count* sizeof(McAbility));
    return buf;
}

static void BuildAndSendMulticlassInfo(Client* c) {
    if (!c) return;

    std::vector<McClass>  classes;
    std::vector<McAA>     aas;
    std::vector<McSpell>  spells;
    std::vector<McSkill>  skills;
    std::vector<McDisc>   discs;
    std::vector<McAbility>abilities;

    GatherClasses(c, classes);
    GatherAAs(c, aas);
    GatherSpells(c, spells);
    GatherSkills(c, skills);
    GatherDiscs(c, discs);
    GatherAbilities(c, abilities);

    MulticlassInfo hdr{};
    hdr.char_id = c->CharacterID();

    uint32 class_mask = 0;
    for (auto& mc : classes) {
        if (mc.class_id >= 1 && mc.class_id <= 16) {
            class_mask |= (1u << (mc.class_id - 1));
        }
    }
    LogInfo("[THJ] SendMulticlassInfo mask=0x{:08X} classes={} aas={} spells={} skills={} discs={} abilities={}",
            class_mask,
            classes.size(),
            aas.size(),
            spells.size(),
            skills.size(),
            discs.size(),
            abilities.size());

    THJ::SetMulticlassMask(c->CharacterID(), class_mask);
    c->SetBucket("GestaltClasses", std::to_string(class_mask));

    auto bytes = Serialize(hdr, classes, aas, spells, skills, discs, abilities);

    // Queue as a single packet:
    auto out = new EQApplicationPacket(OP_MulticlassInfo, bytes.size());
    memcpy(out->pBuffer, bytes.data(), bytes.size());
    c->FastQueuePacket(&out);
}

void Client::SendMulticlassInfo()
{
    constexpr uint16 kGestaltOpcode = 0x7F01;

    // Send simple uint32_t mask packet for client multiclass handler
    // Client expects: opcode 0x7F01 with just the 4-byte class mask
    uint32_t mask = GetClassesMask();

    if (!mask) {
        // Fallback to current class if no mask is set
        mask = GetPlayerClassBit(GetClass());
            LogInfo("[THJ] SendMulticlassInfo: No mask found, using fallback class bit. char_id={} mask=0x{:08X}",

                CharacterID(), mask);

    }

 

    const auto client_version = ClientVersion();
    const uint32 client_version_bit = ClientVersionBit();
    const char *client_version_name = EQ::versions::ClientVersionName(client_version);

    uint16 eq_opcode = 0;
    if (Connection() && Connection()->GetOpcodeManager()) {
        eq_opcode = Connection()->GetOpcodeManager()->EmuToEQ(OP_MulticlassInfo);
    }

    bool forced_opcode = false;
    if (!eq_opcode) {
        eq_opcode = kGestaltOpcode;
        forced_opcode = true;
    }

    LogInfo("[THJ] SendMulticlassInfo: Sending packet to char_id={} with mask=0x{:08X} (size={} bytes) version={} bit=0x{:08X} eq_opcode=0x{:04X}",
            CharacterID(),
            mask,
            sizeof(uint32_t),
            client_version_name ? client_version_name : "Unknown",
            client_version_bit,
            eq_opcode);

 

    // Create packet with just the uint32_t mask

    auto outapp = new EQApplicationPacket(OP_MulticlassInfo, sizeof(uint32_t));

    if (!outapp || !outapp->pBuffer) {

        LogError("[THJ] SendMulticlassInfo: Failed to allocate packet!");

        return;

    }

 

    *(uint32_t*)outapp->pBuffer = mask;

 

    // If we had to force the opcode, bypass the opcode manager so the raw EQ opcode is used.
    if (forced_opcode) {
        outapp->SetOpcodeBypass(eq_opcode);
        LogInfo("[THJ] SendMulticlassInfo: Forced opcode bypass to 0x{:04X}", eq_opcode);
    }

    // Log the actual bytes being sent for debugging

    LogInfo("[THJ] SendMulticlassInfo: Packet bytes: {:02X} {:02X} {:02X} {:02X}",

            outapp->pBuffer[0], outapp->pBuffer[1], outapp->pBuffer[2], outapp->pBuffer[3]);

 

    FastQueuePacket(&outapp);

 

    LogInfo("[THJ] SendMulticlassInfo: Packet queued successfully");
}

// ─── Edge Stat Packet (opcode 0x1338) ───────────────────────────────
// Sends HP, mana, endurance, AC, ATK, base stats, resists, and weight
// to the client DLL for display.  The DLL's label hooks read from the
// statEntries map populated by OnRecvEdgeStatLabelPacket().
//
// Stat keys (must match DLL eStatEntry enum in MQ2Labels.cpp):
//   2=CurHP, 3=CurMana, 4=CurEndur, 5=MaxHP, 6=MaxMana, 7=MaxEndur,
//   8=ATK, 9=AC, 10=STR, 11=STA, 12=DEX, 13=AGI, 14=INT, 15=WIS,
//   16=CHA, 17=MR, 18=FR, 19=CR, 20=PR, 21=DR, 23=Weight

// DLL is compiled with /Zp1 (StructMemberAlignment=1Byte), so its
// EdgeStatEntry_Struct { uint32_t statKey; uint64_t statValue; } = 12 bytes,
// NOT 16.  Match that exactly here.
#pragma pack(push, 1)
struct EdgeStatEntryWire {
    uint32_t stat_key;
    uint64_t stat_value;
};
#pragma pack(pop)
static_assert(sizeof(EdgeStatEntryWire) == 12, "Must match DLL EdgeStatEntry_Struct (/Zp1)");

void Client::SendEdgeStatPacket()
{
    constexpr uint32_t kCount = 22;
    constexpr size_t kPktSize = sizeof(uint32_t) + kCount * sizeof(EdgeStatEntryWire);

    uint8_t buf[kPktSize];
    memset(buf, 0, kPktSize);

    *(uint32_t*)buf = kCount;

    auto* entries = reinterpret_cast<EdgeStatEntryWire*>(buf + sizeof(uint32_t));
    int i = 0;
    // HP / Mana / Endurance
    entries[i++] = { 2,  static_cast<uint64_t>(GetHP()) };            // eStatCurHP
    entries[i++] = { 5,  static_cast<uint64_t>(GetMaxHP()) };         // eStatMaxHP
    entries[i++] = { 3,  static_cast<uint64_t>(GetMana()) };          // eStatCurMana
    entries[i++] = { 6,  static_cast<uint64_t>(GetMaxMana()) };       // eStatMaxMana
    entries[i++] = { 4,  static_cast<uint64_t>(GetEndurance()) };     // eStatCurEndur
    entries[i++] = { 7,  static_cast<uint64_t>(GetMaxEndurance()) };  // eStatMaxEndur
    // AC / ATK
    entries[i++] = { 9,  static_cast<uint64_t>(GetAC()) };            // eStatAC
    entries[i++] = { 8,  static_cast<uint64_t>(GetATK()) };           // eStatATK
    // Base stats
    entries[i++] = { 10, static_cast<uint64_t>(GetSTR()) };           // eStatSTR
    entries[i++] = { 11, static_cast<uint64_t>(GetSTA()) };           // eStatSTA
    entries[i++] = { 12, static_cast<uint64_t>(GetDEX()) };           // eStatDEX
    entries[i++] = { 13, static_cast<uint64_t>(GetAGI()) };           // eStatAGI
    entries[i++] = { 14, static_cast<uint64_t>(GetINT()) };           // eStatINT
    entries[i++] = { 15, static_cast<uint64_t>(GetWIS()) };           // eStatWIS
    entries[i++] = { 16, static_cast<uint64_t>(GetCHA()) };           // eStatCHA
    // Resists
    entries[i++] = { 17, static_cast<uint64_t>(GetMR()) };            // eStatMR
    entries[i++] = { 18, static_cast<uint64_t>(GetFR()) };            // eStatFR
    entries[i++] = { 19, static_cast<uint64_t>(GetCR()) };            // eStatCR
    entries[i++] = { 20, static_cast<uint64_t>(GetPR()) };            // eStatPR
    entries[i++] = { 21, static_cast<uint64_t>(GetDR()) };            // eStatDR
    // Weight (DLL divides by 10.0 for display, so send in tenths)
    entries[i++] = { 24, static_cast<uint64_t>(CalcCurrentWeight()) }; // eStatWeight (24, NOT 23 which is eStatRunspeed!)
    // Max weight: STR-based, or monk weight table (send in tenths to match)
    {
        int wl = GetSTR();
        auto lvl = GetLevel();
        if (HasAnyClass(Class::Monk)) {
            if (lvl > 99)       wl = 58;
            else if (lvl > 94)  wl = 57;
            else if (lvl > 89)  wl = 56;
            else if (lvl > 84)  wl = 55;
            else if (lvl > 79)  wl = 54;
            else if (lvl > 64)  wl = 53;
            else if (lvl > 63)  wl = 50;
            else if (lvl > 61)  wl = 47;
            else if (lvl > 59)  wl = 45;
            else if (lvl > 54)  wl = 40;
            else if (lvl > 50)  wl = 38;
            else if (lvl > 44)  wl = 36;
            else if (lvl > 29)  wl = 34;
            else if (lvl > 14)  wl = 32;
            else                wl = 30;
        }
        entries[i++] = { 25, static_cast<uint64_t>(wl * 10) }; // eStatMaxWeight
    }

    auto outapp = new EQApplicationPacket(OP_Unknown, kPktSize);
    memcpy(outapp->pBuffer, buf, kPktSize);
    outapp->SetOpcodeBypass(0x1338);

    FastQueuePacket(&outapp);
}

static void GatherClasses(Client* c, std::vector<McClass>& out)
{
    out.clear();
    if (!c)
        return;

    out.reserve(3);
    c->ForEachClass([&](uint8 cls) {
        if (!cls)
            return;
        McClass entry{};
        entry.class_id = cls;
        entry.level = static_cast<uint8>(std::min<uint8>(c->GetLevel(), 255));
        out.push_back(entry);
    });
}

static void GatherAAs(Client* c, std::vector<McAA>& out)
{
    out.clear();
    (void)c;
}

static void GatherSpells(Client* c, std::vector<McSpell>& out)
{
    out.clear();
    (void)c;
}

static void GatherSkills(Client* c, std::vector<McSkill>& out)
{
    out.clear();
    (void)c;
}

static void GatherDiscs(Client* c, std::vector<McDisc>& out)
{
    out.clear();
    (void)c;
}

static void GatherAbilities(Client* c, std::vector<McAbility>& out)
{
    out.clear();
    (void)c;
}
