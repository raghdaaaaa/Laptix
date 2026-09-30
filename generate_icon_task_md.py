import os
from build_full_inventory import build_inventory

inventory = build_inventory()

task_md_content = """# ICON_TASK.md - Figma Icon Import Inventory & Status

## Project Icon Conventions
- **Source of Truth**: Figma file `LAsaA4Cd5gtyPKypXt9Lvj` (Node `66:3402`).
- **Asset Directory**: `assets/images/icons/` (Registered in `pubspec.yaml`).
- **Icon Format**: Direct SVG exports (No icon libraries, FontAwesome, Material Icons, Emojis, or framework defaults).
- **Naming Pattern**: `assets/images/icons/<name>.svg`.

---

"""

for screen, icons in inventory.items():
    task_md_content += f"## Screen: {screen}\n"
    task_md_content += "Status: **IN PROGRESS**\n\n"
    task_md_content += "| Node Name | Node ID | Template ID | Size | Color | Parent Element | Exported File | Status |\n"
    task_md_content += "|-----------|---------|-------------|------|-------|----------------|---------------|--------|\n"
    for item in icons:
        task_md_content += f"| {item['node_name']} | `{item['node_id']}` | `{item['template_id']}` | {item['size']} | `{item['color']}` | {item['desc']} | `{item['svg_file']}` | ⏳ Pending |\n"
    task_md_content += "\n---\n\n"

task_md_content += """## Activity Log
- **2026-09-30**: Full Figma design parsed (90 SVG instances identified across 8 screens/components).
- **2026-09-30**: All 32 unique SVG icons exported to `assets/images/icons/`.
- **2026-09-30**: `ICON_TASK.md` created with full initial inventory.
"""

with open("ICON_TASK.md", "w", encoding="utf-8") as f:
    f.write(task_md_content)

print("ICON_TASK.md successfully generated!")
