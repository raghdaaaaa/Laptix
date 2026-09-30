import os
import re
import json

def build_inventory():
    with open("figma_full.txt", "r", encoding="utf-16") as f:
        content = f.read()

    lines = content.replace('\\n', '\n').split('\n')

    screen_ranges = [
        ("Welcome Screen", 2708, 2803),
        ("Questionnaire - Step 1", 2804, 2882),
        ("Questionnaire - Step 2", 2883, 2994),
        ("Questionnaire - Step 3", 2995, 3090),
        ("Recommendation Result", 3091, 3192),
        ("Laptop Checker Screen", 3231, 3375),
        ("Bottom Navigation Bar", 3202, 3230),
        ("Design System", 2495, 2707)
    ]

    template_map = {
        "EL-68a0fd94": ("icon_menu.svg", "16x18", "Menu / Hamburger"),
        "EL-c4d4cd88": ("icon_zap.svg", "14x16", "Lightning / Speed"),
        "EL-56ca6762": ("icon_arrow_forward.svg", "13x14", "Arrow Forward / Right"),
        "EL-a038b61d": ("icon_search.svg", "14x15", "Search Lens"),
        "EL-13e09156": ("icon_chevron_left.svg", "12x18", "Back Arrow / Chevron Left"),
        "EL-87967210": ("icon_close.svg", "14x18", "Close Cross"),
        "EL-4955d9fa": ("major_computer_science.svg", "30x24", "Laptop / Tech Major"),
        "EL-762d5cce": ("major_business.svg", "24x24", "Chart / Business Major"),
        "EL-8e2b51a7": ("usage_gaming.svg", "23x20", "Gamepad / Gaming"),
        "EL-6916852e": ("icon_toggle.svg", "25x20", "Toggle Switch"),
        "EL-eade9af0": ("icon_edit.svg", "20x20", "Edit / Pencil"),
        "EL-538d2411": ("icon_check_small.svg", "9x10", "Checkmark Small"),
        "EL-4709d636": ("spec_processor.svg", "16x16", "CPU Processor Chip"),
        "EL-dabee1f5": ("spec_memory.svg", "18x16", "RAM Memory Module"),
        "EL-d5eea754": ("icon_suitable_check.svg", "18x20", "Suitable Status Check"),
        "EL-41afa4a2": ("icon_chevron_down.svg", "12x12", "Chevron Down Arrow"),
        "EL-1256b0d4": ("nav_home.svg", "21x18", "Home Nav Icon"),
        "EL-97294bbc": ("nav_checker.svg", "23x18", "Checker Nav Icon"),
        "EL-b8290adc": ("nav_explore.svg", "18x18", "Explore Nav Icon"),
    }

    no_template_map = {
        "64:2740": ("hero_illustration_graphic.svg", "15x12", "Hero Decorative Shape"),
        "64:2879": ("major_other.svg", "11x12", "Major Other Icon"),
        "64:3019": ("budget_pro.svg", "16x14", "Budget Tier Icon"),
        "64:3087": ("status_badge_huge.svg", "128x128", "Status Badge Large"),
        "64:3119": ("rec_laptop_card.svg", "27x31", "Laptop Card Graphic"),
        "64:3175": ("checker_result_badge.svg", "96x96", "Result Graphic"),
        "64:3188": ("checker_spec_icon.svg", "75x60", "Checker Hardware Graphic"),
        "64:3299": ("checker_alert_warning.svg", "22x24", "Warning Indicator"),
        "64:3361": ("checker_bg_pattern.svg", "45x61", "Background Decorative Pattern"),
        "64:3366": ("checker_info_dot.svg", "12x16", "Info Dot Indicator"),
        "64:2587": ("ds_sample_icon.svg", "38x30", "Design System Sample"),
        "64:2699": ("ds_status_warning.svg", "15x20", "Design System Status Warning")
    }

    inventory = {}

    for line in lines:
        svg_m = re.search(r'\[IMAGE-SVG\]\s*\\?"([^"]+)\\?"\s*#(\d+:\d+)', line)
        if svg_m:
            nodename = svg_m.group(1)
            nid = svg_m.group(2)
            num = int(nid.split(':')[1])

            # Determine screen by node range
            screen = "Design System"
            for sname, smin, smax in screen_ranges:
                if smin <= num <= smax:
                    screen = sname
                    break

            template_m = re.search(r'template=(EL-[a-f0-9]+)', line)
            tmpl = template_m.group(1) if template_m else "no-template"

            fills_m = re.search(r'fills=([^\s]+)', line)
            fills = fills_m.group(1) if fills_m else "default"

            dims_m = re.search(r'dimensions=\{([^}]+)\}', line)
            dims = dims_m.group(1) if dims_m else ""

            if tmpl in template_map:
                svg_file, default_dims, desc = template_map[tmpl]
            elif nid in no_template_map:
                svg_file, default_dims, desc = no_template_map[nid]
            else:
                svg_file = f"ic_{nid.replace(':', '_')}.svg"
                default_dims = "16x16"
                desc = f"SVG Icon #{nid}"

            size_str = dims if dims else default_dims

            icon_item = {
                "node_name": nodename,
                "node_id": nid,
                "template_id": tmpl,
                "svg_file": svg_file,
                "size": size_str,
                "color": fills,
                "desc": desc,
                "screen": screen
            }

            if screen not in inventory:
                inventory[screen] = []
            inventory[screen].append(icon_item)

    return inventory

inv = build_inventory()
total = 0
for sc, items in inv.items():
    print(f"[{sc}] : {len(items)} icons")
    total += len(items)

print(f"\nTOTAL ICONS: {total}")
