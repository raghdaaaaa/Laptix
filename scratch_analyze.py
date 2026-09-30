import os
import re

def try_read(path):
    for enc in ['utf-16', 'utf-8', 'utf-8-sig', 'cp1252']:
        try:
            with open(path, 'r', encoding=enc) as f:
                content = f.read()
                print(f"Success with {enc}, length={len(content)}")
                return content
        except Exception as e:
            pass
    return None

content = try_read("figma_full.txt")
if not content:
    content = try_read("figma_full_output.json")

lines = content.replace('\\n', '\n').split('\n')
print(f"Total unescaped lines: {len(lines)}")

# Find all [FRAME] lines at top level or screens
screens = [
    "Welcome Screen",
    "Questionnaire - Step 1",
    "Questionnaire - Step 2",
    "Questionnaire - Step 3",
    "Recommendation Result",
    "Laptop Checker",
    "Frame", # Navigation bar frame or container
    "Laptix Design System"
]

svg_nodes = []
current_screen = "Global / System"
current_parents = []

for line in lines:
    frame_m = re.search(r'\[FRAME\]\s*"([^"]+)"\s*#(\d+:\d+)', line)
    if frame_m:
        fname = frame_m.group(1)
        nid = frame_m.group(2)
        if any(s in fname for s in ["Welcome", "Questionnaire", "Recommendation", "Laptop Checker", "Frame", "Laptix"]):
            current_screen = fname
            print(f"\n--- SCREEN: {current_screen} (#{nid}) ---")
    
    svg_m = re.search(r'\[IMAGE-SVG\]\s*"([^"]+)"\s*#(\d+:\d+)', line)
    if svg_m:
        name = svg_m.group(1)
        nid = svg_m.group(2)
        template_m = re.search(r'template=(EL-[a-f0-9]+)', line)
        tmpl = template_m.group(1) if template_m else "no-template"
        fills_m = re.search(r'fills=([^\s]+)', line)
        fills = fills_m.group(1) if fills_m else "default"
        dims_m = re.search(r'dimensions=\{([^}]+)\}', line)
        dims = dims_m.group(1) if dims_m else "default"
        print(f"  SVG: {name} | Node #{nid} | Template: {tmpl} | Fills: {fills} | Dims: {dims}")
