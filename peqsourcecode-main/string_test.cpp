#include <iostream>
#include <string>
#include <cstdio>
#include <cstdint>
#include <cstring>
#include <vector>
#include <cstdarg>

std::string StringFormat(const char* format, ...) {
    char buffer[256];
    va_list args;
    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    va_end(args);
    return std::string(buffer);
}

std::string saylink_silent(const std::string& text, const std::string& link_name, uint32_t sayid) {
    uint8_t action_id = 0;
    uint32_t item_id = 0xFFFFF;
    uint32_t augment_1 = 0;
    uint32_t augment_2 = sayid; 
    uint32_t augment_3 = 0;
    uint32_t augment_4 = 0;
    uint32_t augment_5 = 0;
    uint32_t augment_6 = 0;
    uint8_t is_evolving = 0;
    uint32_t evolve_group = 0;
    uint8_t evolve_level = 0;
    uint32_t ornament_icon = 0;
    uint32_t hash = 0x14505DC2;

    std::string m_LinkBody = StringFormat(
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

    std::string m_Link;
    m_Link.push_back('\x12');
    m_Link.append(m_LinkBody);
    m_Link.append(link_name);
    m_Link.push_back('\x12');
    return m_Link;
}

int main() {
    std::string reload_slug = "tasks";
    std::string reload_link = saylink_silent("#reload tasks", "Local", 68);
    std::string reload_link_global = saylink_silent("#reload tasks global", "Global", 69);
    
    std::string output = "Usage: [" + reload_link + "] [" + reload_link_global + "] #reload " + reload_slug + " - Reloads Tasks";
    
    std::cout << "Exact Output:" << std::endl;
    std::cout << output << std::endl;
    // print hex dump
    for (char c : output) {
        if (c == '\x12') {
            std::cout << "\\x12";
        } else {
            std::cout << c;
        }
    }
    std::cout << std::endl;
    return 0;
}
