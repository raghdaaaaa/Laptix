import os
import glob
import xml.etree.ElementTree as ET

icons_dir = r"E:\Flutter\Antigravity IDE\icons_export"

svg_files = glob.glob(os.path.join(icons_dir, "*.svg"))

print(f"Total exported SVGs found: {len(svg_files)}")

for path in sorted(svg_files):
    fname = os.path.basename(path)
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Simple XML parse or string inspection
    width = ""
    height = ""
    fill = ""
    path_d = ""
    
    if 'width="' in content:
        width = content.split('width="')[1].split('"')[0]
    if 'height="' in content:
        height = content.split('height="')[1].split('"')[0]
    if 'fill="' in content:
        fill = content.split('fill="')[1].split('"')[0]
        
    print(f"\nFILE: {fname} ({width}x{height}, fill: {fill})")
    # Show first path or elements
    paths = content.split('<path ')
    if len(paths) > 1:
        d_str = paths[1].split('d="')[1].split('"')[0] if 'd="' in paths[1] else ""
        print(f"  Path sample: {d_str[:80]}...")
    else:
        print(f"  Content snippet: {content[:150]}...")
