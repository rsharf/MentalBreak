# Zone Transporter NPC - Teleports to all accessible zones
# Placed next to Multiclass Master in Plane of Knowledge

my %zones = (
    # Expansion 0: Classic
    "classic" => {
        label => "Classic EverQuest",
        zones => [
            # [short_name, long_name, zone_id, safe_x, safe_y, safe_z, level_range]
            ["qeynos", "South Qeynos", 1, 0, 10, 5, "City"],
            ["qeynos2", "North Qeynos", 2, -74, 428, 3, "City"],
            ["qrg", "Surefall Glade", 3, 0, 0, 2, "City"],
            ["qeytoqrg", "Qeynos Hills", 4, 83, 508, 0, "1-12"],
            ["highpass", "Highpass Hold", 5, -104, -14, 4, "10-25"],
            ["highkeep", "High Keep", 6, 88, -16, 4, "15-35"],
            ["freportw", "West Freeport", 9, 181, 335, -24, "City"],
            ["freporte", "East Freeport", 10, -648, -1097, -52, "City"],
            ["freportn", "North Freeport", 8, 211, -296, 4, "City"],
            ["runnyeye", "Liberated Citadel of Runnyeye", 11, 201, 90, 4, "8-20"],
            ["qey2hh1", "Western Karana", 12, -531, 15, -3, "10-25"],
            ["northkarana", "Northern Karana", 13, -382, -284, -8, "15-30"],
            ["southkarana", "Southern Karana", 14, 1294, 2348, -6, "15-30"],
            ["eastkarana", "Eastern Karana", 15, 865, 15, -33, "15-35"],
            ["beholder", "Gorge of King Xorbb", 16, -21, -512, 45, "20-35"],
            ["blackburrow", "Blackburrow", 17, 39, -159, 3, "5-15"],
            ["paw", "Lair of the Splitpaw", 18, 63, -122, 3, "8-20"],
            ["rivervale", "Rivervale", 19, 0, 0, 4, "City"],
            ["kithicor", "Kithicor Forest", 20, 3828, 1889, 459, "20-35"],
            ["commons", "West Commonlands", 21, -1334, 210, -51, "5-15"],
            ["ecommons", "East Commonlands", 22, -1485, 9, -51, "5-15"],
            ["erudnint", "Erudin Palace", 23, 808, 712, 21, "City"],
            ["erudnext", "Erudin", 24, -338, 75, 20, "City"],
            ["nektulos", "Nektulos Forest", 25, -259, -1201, -5, "10-25"],
            ["lavastorm", "Lavastorm Mountains", 27, -25, 182, -74, "25-45"],
            ["halas", "Halas", 29, 0, 0, 3, "City"],
            ["everfrost", "Everfrost Peaks", 30, 629, 3139, -60, "10-25"],
            ["soldunga", "Solusek's Eye", 31, -486, -476, 73, "20-35"],
            ["soldungb", "Nagafen's Lair", 32, -263, -424, -108, "30-50"],
            ["misty", "Misty Thicket", 33, 0, 0, 2, "1-10"],
            ["nro", "Northern Desert of Ro", 34, 299, 3538, -25, "10-25"],
            ["sro", "Southern Desert of Ro", 35, 286, 1265, 79, "10-25"],
            ["befallen", "Befallen", 36, 35, -82, 3, "10-25"],
            ["oasis", "Oasis of Marr", 37, 904, 490, 6, "15-30"],
            ["tox", "Toxxulia Forest", 38, 203, 2295, -45, "5-15"],
            ["hole", "The Hole", 39, -1050, 640, -80, "35-55"],
            ["neriaka", "Neriak - Foreign Quarter", 40, 157, -3, 31, "City"],
            ["neriakb", "Neriak - Commons", 41, -500, 3, -10, "City"],
            ["neriakc", "Neriak - 3rd Gate", 42, -969, 892, -52, "City"],
            ["najena", "Najena", 44, 858, -76, 4, "20-35"],
            ["qcat", "Qeynos Aqueducts", 45, 80, 860, -38, "5-15"],
            ["innothule", "Innothule Swamp", 46, -588, -2192, -25, "5-15"],
            ["feerrott", "The Feerrott", 47, 905, 1051, 25, "10-25"],
            ["cazicthule", "Accursed Temple of CazicThule", 48, -74, 71, 4, "25-45"],
            ["oggok", "Oggok", 49, -99, -345, 4, "City"],
            ["rathemtn", "Rathe Mountains", 50, 1831, 3825, 28, "20-40"],
            ["lakerathe", "Lake Rathetear", 51, 1213, 4183, 3, "20-40"],
            ["grobb", "Grobb", 52, 0, -100, 3, "City"],
            ["gfaydark", "Greater Faydark", 54, 10, -20, 0, "1-10"],
            ["akanon", "Ak'Anon", 55, -35, 47, 4, "City"],
            ["steamfont", "Steamfont Mountains", 56, -273, 160, -21, "5-15"],
            ["lfaydark", "Lesser Faydark", 57, -1770, -108, 0, "10-25"],
            ["crushbone", "Crushbone", 58, 158, -644, 4, "5-20"],
            ["mistmoore", "Castle Mistmoore", 59, 120, -330, -178, "20-40"],
            ["kaladima", "South Kaladim", 60, -2, -18, 3, "City"],
            ["felwithea", "Northern Felwithe", 61, 94, -25, 3, "City"],
            ["felwitheb", "Southern Felwithe", 62, -790, 320, -10, "City"],
            ["unrest", "Estate of Unrest", 63, 52, -38, 3, "15-35"],
            ["kedge", "Kedge Keep", 64, 14, 100, 302, "30-50"],
            ["guktop", "Upper Guk", 65, 7, -36, 4, "10-25"],
            ["gukbottom", "Ruins of Old Guk", 66, -217, 1197, -78, "30-50"],
            ["kaladimb", "North Kaladim", 67, -267, 414, 4, "City"],
            ["butcher", "Butcherblock Mountains", 68, -700, 2550, 3, "5-20"],
            ["oot", "Ocean of Tears", 69, -9200, 390, 6, "20-35"],
            ["cauldron", "Dagnor's Cauldron", 70, 320, 2815, 473, "20-35"],
            ["airplane", "Plane of Sky", 71, 614, 1415, -650, "46-60"],
            ["fearplane", "Plane of Fear", 72, 1282, -1139, 5, "46-60"],
            ["permafrost", "Permafrost Caverns", 73, 61, -121, 2, "20-40"],
            ["kerraridge", "Kerra Isle", 74, -860, 475, 24, "15-30"],
            ["paineel", "Paineel", 75, 200, 800, 3, "City"],
            ["arena", "The Arena", 77, 146, -1009, 51, "PvP"],
            ["soltemple", "Temple of Solusek Ro", 80, 36, 262, 0, "40-55"],
            ["erudsxing", "Erud's Crossing", 98, 795, -1767, 11, "15-30"],
            ["jaggedpine", "Jaggedpine Forest", 181, 1800, 1319, -13, "25-45"],
            ["hateplane", "Plane of Hate (Original)", 76, 0, 0, 5, "46-60"],
            ["hateplaneb", "Plane of Hate", 186, -393, 656, 3, "46-60"],
        ],
    },
    # Expansion 1: Kunark
    "kunark" => {
        label => "Ruins of Kunark",
        zones => [
            ["fieldofbone", "Field of Bone", 78, 1617, -1684, -50, "1-15"],
            ["warslikswood", "Warsliks Woods", 79, -468, -1429, 198, "10-25"],
            ["droga", "Temple of Droga", 81, 290, 1375, 6, "30-45"],
            ["cabwest", "Cabilis West", 82, 767, -783, 8, "City"],
            ["swampofnohope", "Swamp of No Hope", 83, 2945, 2761, 6, "10-25"],
            ["firiona", "Firiona Vie", 84, 1440, -2392, 1, "15-35"],
            ["lakeofillomen", "Lake of Ill Omen", 85, -5383, 5747, 70, "15-30"],
            ["dreadlands", "The Dreadlands", 86, 9565, 2806, 1050, "25-45"],
            ["burningwood", "Burning Wood", 87, -821, -4942, 204, "30-50"],
            ["kaesora", "Kaesora", 88, 40, 370, 102, "30-45"],
            ["sebilis", "Ruins of Sebilis", 89, 0, 250, 44, "45-60"],
            ["citymist", "City of Mist", 90, -734, 28, 4, "35-55"],
            ["skyfire", "Skyfire Mountains", 91, -4286, -1140, 38, "40-55"],
            ["frontiermtns", "Frontier Mountains", 92, -4262, -633, 116, "20-40"],
            ["overthere", "The Overthere", 93, 1450, -3500, 309, "25-45"],
            ["emeraldjungle", "Emerald Jungle", 94, 4648, -1223, 2, "35-55"],
            ["trakanon", "Trakanon's Teeth", 95, 1486, 3868, -336, "30-50"],
            ["timorous", "Timorous Deep", 96, 2194, -5392, 6, "20-40"],
            ["kurn", "Kurn's Tower", 97, 0, 0, 7, "5-20"],
            ["chardok", "Chardok", 103, 859, 119, 106, "45-60"],
            ["dalnir", "Crypt of Dalnir", 104, 0, 0, 6, "25-40"],
            ["charasis", "Howling Stones", 105, 0, 0, 4, "45-60"],
            ["cabeast", "Cabilis East", 106, -417, 1362, 8, "City"],
            ["nurga", "Mines of Nurga", 107, -1762, -2200, 6, "25-40"],
            ["veeshan", "Veeshan's Peak", 108, 1783, -5, 15, "55-65"],
            ["karnor", "Karnor's Castle", 102, 302, 18, 6, "40-55"],
        ],
    },
    # Expansion 2: Velious
    "velious" => {
        label => "Scars of Velious",
        zones => [
            ["veksar", "Veksar", 109, 1, -486, -27, "45-55"],
            ["iceclad", "Iceclad Ocean", 110, 340, 5330, -17, "25-45"],
            ["frozenshadow", "Tower of Frozen Shadow", 111, 200, 120, 0, "30-55"],
            ["velketor", "Velketor's Labyrinth", 112, -65, 581, -152, "40-55"],
            ["kael", "Kael Drakkel", 113, -633, -47, 128, "45-60"],
            ["skyshrine", "Skyshrine", 114, -730, -210, 0, "45-60"],
            ["thurgadina", "City of Thurgadin", 115, 0, -1222, 0, "City"],
            ["eastwastes", "Eastern Wastes", 116, -4296, -5049, 147, "30-50"],
            ["cobaltscar", "Cobalt Scar", 117, 895, -939, 318, "40-55"],
            ["greatdivide", "Great Divide", 118, -965, -7720, -557, "25-45"],
            ["wakening", "Wakening Land", 119, -5000, -673, -195, "35-55"],
            ["westwastes", "Western Wastes", 120, -3499, -4099, -18, "45-60"],
            ["crystal", "Crystal Caverns", 121, 303, 487, -74, "25-45"],
            ["necropolis", "Dragon Necropolis", 123, 2000, -100, 5, "50-60"],
            ["templeveeshan", "Temple of Veeshan", 124, -499, -2086, -36, "55-65"],
            ["sirens", "Siren's Grotto", 125, -33, 196, 4, "40-55"],
            ["mischiefplane", "Plane of Mischief", 126, -395, -1410, 115, "45-55"],
            ["growthplane", "Plane of Growth", 127, 3016, -2522, -19, "46-55"],
            ["sleeper", "Sleeper's Tomb", 128, 0, 0, 5, "55-65"],
            ["thurgadinb", "Icewell Keep", 129, 0, 250, 0, "50-60"],
            ["stonebrunt", "Stonebrunt Mountains", 100, -1643, -3428, -7, "25-40"],
            ["warrens", "The Warrens", 101, -930, 748, -37, "5-20"],
        ],
    },
    # Expansion 3: Luclin
    "luclin" => {
        label => "Shadows of Luclin",
        zones => [
            ["shadowhaven", "Shadow Haven", 150, 190, -982, -28, "Hub"],
            ["nexus", "The Nexus", 152, 0, 0, -28, "Hub"],
            ["echo", "Echo Caverns", 153, -800, 840, -25, "25-40"],
            ["acrylia", "Acrylia Caverns", 154, -665, 20, 4, "35-55"],
            ["sharvahl", "City of Shar Vahl", 155, 85, -1135, -188, "City"],
            ["paludal", "Paludal Caverns", 156, -241, -3721, 195, "10-25"],
            ["fungusgrove", "Fungus Grove", 157, -1005, -2140, -308, "35-55"],
            ["vexthal", "Vex Thal", 158, -1655, 257, -35, "55-65"],
            ["sseru", "Sanctus Seru", 159, -232, 1166, 59, "30-50"],
            ["katta", "Katta Castellum", 160, -545, 645, 1, "30-50"],
            ["netherbian", "Netherbian Lair", 161, 14, 1787, -62, "25-40"],
            ["ssratemple", "Ssraeshza Temple", 162, 0, 0, 4, "50-65"],
            ["griegsend", "Grieg's End", 163, 3461, -19, -5, "40-55"],
            ["thedeep", "The Deep", 164, -700, -398, -60, "45-60"],
            ["shadeweaver", "Shadeweaver's Thicket", 165, -3570, -2122, -93, "1-15"],
            ["hollowshade", "Hollowshade Moor", 166, 2420, 1241, 40, "10-25"],
            ["grimling", "Grimling Forest", 167, -1020, -950, 22, "15-30"],
            ["mseru", "Marus Seru", 168, -1668, 540, -6, "25-40"],
            ["letalis", "Mons Letalis", 169, -623, -1249, -29, "30-45"],
            ["twilight", "Twilight Sea", 170, -1858, -420, -10, "25-40"],
            ["thegrey", "The Grey", 171, 349, -1994, -26, "30-50"],
            ["tenebrous", "Tenebrous Mountains", 172, 1810, 51, -36, "25-40"],
            ["maiden", "Maiden's Eye", 173, 1905, 940, -150, "30-50"],
            ["dawnshroud", "Dawnshroud Peaks", 174, 2085, 0, 89, "20-40"],
            ["scarlet", "Scarlet Desert", 175, -1678, -1054, -98, "35-55"],
            ["umbral", "Umbral Plains", 176, 1900, -474, 23, "40-60"],
            ["akheva", "Akheva Ruins", 179, 60, -1395, 22, "45-60"],
        ],
    },
    # Expansion 4: Planes of Power
    "pop" => {
        label => "Planes of Power",
        zones => [
            ["poknowledge", "Plane of Knowledge", 202, -285, -148, -159, "Hub"],
            ["potranquility", "Plane of Tranquility", 203, -1507, 701, -878, "Hub"],
            ["ponightmare", "Plane of Nightmares", 204, 1668, 282, 212, "55-62"],
            ["podisease", "Plane of Disease", 205, -1750, -1245, -56, "55-62"],
            ["poinnovation", "Plane of Innovation", 206, 263, 516, -53, "55-62"],
            ["potorment", "Torment, Plane of Pain", 207, -341, 1706, -491, "55-62"],
            ["povalor", "Plane of Valor", 208, 190, -1668, 65, "55-62"],
            ["bothunder", "Bastion of Thunder", 209, 178, 207, -1620, "57-65"],
            ["postorms", "Plane of Storms", 210, -1795, -2059, -471, "55-62"],
            ["hohonora", "Halls of Honor", 211, -2678, -323, 3, "57-65"],
            ["solrotower", "Tower of Solusek Ro", 212, -1, -2915, -766, "57-65"],
            ["potactics", "Drunder, Fortress of Zek", 214, -210, 10, -35, "57-65"],
            ["poair", "Plane of Air", 215, 532, 884, -90, "57-65"],
            ["powater", "Plane of Water", 216, -165, -1250, 4, "57-65"],
            ["pofire", "Plane of Fire", 217, -1387, 1210, -182, "57-65"],
            ["poeartha", "Plane of Earth A", 218, -1150, 200, 71, "57-65"],
            ["potimea", "Plane of Time A", 219, -37, -110, 8, "62-65"],
            ["potimeb", "Plane of Time B", 223, -37, -110, 8, "62-65"],
            ["hohonorb", "Temple of Marr", 220, 975, 2, 396, "57-65"],
            ["nightmareb", "Lair of Terris Thule", 221, 1608, 30, -327, "57-65"],
            ["poearthb", "Plane of Earth B", 222, -762, 328, -56, "57-65"],
            ["pojustice", "Plane of Justice", 201, 58, -61, 5, "55-62"],
            ["codecay", "Crypt of Decay", 200, -170, -65, -93, "55-62"],
        ],
    },
    # Expansion 5: LoY/LDoN
    "loy" => {
        label => "Legacy of Ykesha / LDoN",
        zones => [
            ["gunthak", "Gulf of Gunthak", 224, -938, 1461, 15, "35-55"],
            ["torgiran", "Torgiran Mines", 226, -620, -323, 5, "40-55"],
            ["nedaria", "Nedaria's Landing", 182, -1737, -181, 256, "40-55"],
        ],
    },
    # Expansion 7: Gates of Discord
    "god" => {
        label => "Gates of Discord",
        zones => [
            ["abysmal", "Abysmal Sea", 279, 0, -199, 140, "Hub"],
            ["natimbi", "Natimbi, Broken Shores", 280, -1557, -853, 239, "55-65"],
            ["barindu", "Barindu, Hanging Gardens", 283, 590, -1457, -123, "60-65"],
            ["kodtaz", "Kod'Taz, Broken Trial Grounds", 293, -1475, 1548, -302, "62-65"],
            ["qvic", "Qvic, Prayer Grounds", 295, -2515, 767, -647, "65-70"],
            ["ikkinz", "Ikkinz, Chambers of Transcendence", 294, 0, 0, 5, "62-68"],
            ["inktuta", "Inktu'Ta, the Unmasked Chapel", 296, 0, 0, 5, "65-70"],
            ["txevu", "Txevu, Lair of the Elite", 297, 0, 0, 5, "65-70"],
            ["tacvi", "Tacvi, The Broken Temple", 298, 0, 0, 5, "65-70"],
        ],
    },
    # Expansion 8: Omens of War
    "oow" => {
        label => "Omens of War",
        zones => [
            ["wallofslaughter", "Wall of Slaughter", 300, -1461, -2263, -69, "55-70"],
            ["provinggrounds", "Muramite Proving Grounds", 316, -124, -5676, -306, "60-70"],
            ["riftseekers", "Riftseekers' Sanctum", 334, -1, 297, -208, "62-70"],
            ["dranik", "Ruined City of Dranik", 336, -1112, -1953, -369, "55-70"],
            ["anguish", "Anguish, the Fallen Palace", 317, 0, 0, 5, "65-70"],
        ],
    },
    # Expansion 9: Dragons of Norrath + Utility
    "don" => {
        label => "Dragons of Norrath / Utility",
        zones => [
            ["guildlobby", "Guild Lobby", 344, 19, -55, 5, "Hub"],
            ["bazaar", "The Bazaar", 151, -71, -250, 33, "Hub"],
            ["tutorialb", "Mines of Gloomingdeep", 189, 18, -147, 20, "1-10"],
        ],
    },
    # Expansions 10-14: DoDH / PoR / TSS / TBS / SoF / SoD Raid Zones
    "raidzones" => {
        label => "Raid Zones (DoDH-SoD)",
        zones => [
            # DoDH
            ["dreadspire", "Dreadspire Keep", 351, 0, 0, 5, "68-75"],
            # PoR
            ["theater", "Theater of Blood", 380, 0, 0, 5, "70-75"],
            ["theatera", "Deathknell, Tower of Dissonance", 381, 0, 0, 5, "70-75"],
            # TSS
            ["ashengate", "Ashengate, Reliquary of the Scale", 406, 0, 0, 5, "70-75"],
            ["frostcrypt", "Frostcrypt, Throne of the Shade King", 402, 0, 0, 5, "70-75"],
            ["valdeholm", "Valdeholm", 401, 0, 0, 5, "70-75"],
            # TBS
            ["solteris", "Solteris, the Throne of Ro", 421, 0, 0, 5, "70-80"],
            # SoF
            ["crystallos", "Crystallos, Lair of the Awakened", 446, 0, 0, 5, "75-80"],
            # SoD
            ["discord", "Korafax, Home of the Riders", 470, 0, 0, 5, "75-85"],
            ["korascian", "Korascian Warrens", 476, 0, 0, 5, "75-85"],
            ["rathechamber", "Rathe Council Chamber", 477, 0, 0, 5, "75-85"],
        ],
    },
);

my @expansion_order = ("classic", "kunark", "velious", "luclin", "pop", "loy", "god", "oow", "don", "raidzones");

sub EVENT_SAY {
    if ($text =~ /hail/i) {
        quest::say("Greetings, traveler. I can transport you to any zone in Norrath.");
        quest::say("Choose an era:");
        quest::say(" ");
        foreach my $exp (@expansion_order) {
            my $label = $zones{$exp}{label};
            my $count = scalar @{$zones{$exp}{zones}};
            quest::say("  $label ($count zones) - say '$exp'");
        }
        quest::say(" ");
        quest::say("Or say a zone short name directly if you know it.");
        return;
    }

    # Check if they said an expansion name
    foreach my $exp (@expansion_order) {
        if ($text =~ /^\Q$exp\E$/i) {
            my $label = $zones{$exp}{label};
            quest::say("-- $label --");
            quest::say(" ");
            my $zone_list = $zones{$exp}{zones};
            foreach my $z (@$zone_list) {
                my ($short, $long, $id, $x, $y, $zcoord, $lvl) = @$z;
                quest::say("  $long ($lvl) - say '$short'");
            }
            quest::say(" ");
            quest::say("Say 'back' to return to the expansion list.");
            return;
        }
    }

    # Check if they said "back"
    if ($text =~ /^back$/i) {
        quest::say("Choose an era:");
        quest::say(" ");
        foreach my $exp (@expansion_order) {
            my $label = $zones{$exp}{label};
            my $count = scalar @{$zones{$exp}{zones}};
            quest::say("  $label ($count zones) - say '$exp'");
        }
        return;
    }

    # Check if they said a zone short name
    foreach my $exp (@expansion_order) {
        my $zone_list = $zones{$exp}{zones};
        foreach my $z (@$zone_list) {
            my ($short, $long, $id, $x, $y, $zcoord, $lvl) = @$z;
            if ($text =~ /^\Q$short\E$/i) {
                quest::say("Transporting you to $long...");
                quest::movepc($id, $x, $y, $zcoord);
                return;
            }
        }
    }

    quest::say("I don't recognize that zone. Say 'hail' to see the full list.");
}
