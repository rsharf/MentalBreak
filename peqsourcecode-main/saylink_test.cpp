#include <iostream>
#include <string>
#include <cstdio>
#include <cstdint>
#include <cstring>
#include <vector>
#include <memory>

int main() {
    uint8_t action_id = 0;
    uint32_t item_id = 0xFFFFF;
    uint32_t augment_1 = 0;
    uint32_t augment_2 = 0x45; // 69 for #reload tasks global
    uint32_t augment_3 = 0;
    uint32_t augment_4 = 0;
    uint32_t augment_5 = 0;
    uint32_t augment_6 = 0;
    uint8_t is_evolving = 0;
    uint32_t evolve_group = 0;
    uint8_t evolve_level = 0;
    uint32_t ornament_icon = 0;
    uint32_t hash = 0x14505DC2;

    char buffer[256];
    snprintf(buffer, 256,
        "%1X" "%05X" "%05X" "%05X" "%05X" "%05X" "%05X" "%05X" "%1X" "%04X" "%02X" "%05X" "%08X",
        (0x0F & action_id),
        (0x000FFFFF & item_id),
        (0x000FFFFF & augment_1),
        (0x000FFFFF & augment_2),
        (0x000FFFFF & augment_3),
        (0x000FFFFF & augment_4),
        (0x000FFFFF & augment_5),
        (0x000FFFFF & augment_6),
        (0x0F & is_evolving),
        (0x0000FFFF & evolve_group),
        (0xFF & evolve_level),
        (0x000FFFFF & ornament_icon),
        (0xFFFFFFFF & hash)
    );

    std::cout << "Original Hash: " << buffer << std::endl;
    std::cout << "Length: " << strlen(buffer) << std::endl;
    
    // Simulate SoF truncation
    std::string s(buffer);
    std::string sof_saylink = "";
    sof_saylink.append(s.substr(0, 31));
    sof_saylink.append(s.substr(36, 5));
    if (s[41] == '0')
        sof_saylink.push_back(s[42]);
    else
        sof_saylink.push_back('F');
    sof_saylink.append(s.substr(43));
    
    std::cout << "SoF Patch Hash: " << sof_saylink << " (len " << sof_saylink.length() << ")" << std::endl;

    // Simulate Titanium truncation
    std::string titanium_saylink = "";
    titanium_saylink.append(s.substr(0, 26));
    titanium_saylink.append(s.substr(43));
    std::cout << "Titanium Patch Hash: " << titanium_saylink << " (len " << titanium_saylink.length() << ")" << std::endl;

    return 0;
}
