import os
import shutil

src_dir = r"E:\Flutter\Antigravity IDE\icons_export"
dst_dir = r"e:\Own\laptix\assets\images\icons"

os.makedirs(dst_dir, exist_ok=True)

mapping = {
    "template_68a0fd94.svg": "ic_menu.svg",
    "ic_profile.svg": "ic_menu.svg", # same hamburger menu icon
    "template_c4d4cd88.svg": "icon_zap.svg",
    "template_56ca6762.svg": "icon_arrow_forward.svg",
    "template_a038b61d.svg": "icon_search.svg",
    "template_13e09156.svg": "icon_chevron_left.svg",
    "template_87967210.svg": "icon_close.svg",
    "template_4955d9fa.svg": "major_computer_science.svg",
    "template_762d5cce.svg": "major_business.svg",
    "template_8e2b51a7.svg": "usage_gaming.svg",
    "template_6916852e.svg": "icon_toggle.svg",
    "template_eade9af0.svg": "icon_edit.svg",
    "template_538d2411.svg": "icon_check_small.svg",
    "template_4709d636.svg": "spec_processor.svg",
    "template_dabee1f5.svg": "spec_memory.svg",
    "template_d5eea754.svg": "icon_suitable_check.svg",
    "template_41afa4a2.svg": "icon_chevron_down.svg",
    "template_1256b0d4.svg": "nav_home.svg",
    "template_97294bbc.svg": "nav_checker.svg",
    "template_b8290adc.svg": "nav_explore.svg",

    "no_template_2740.svg": "hero_illustration_graphic.svg",
    "no_template_2879.svg": "major_other.svg",
    "no_template_3019.svg": "budget_pro.svg",
    "no_template_3087.svg": "status_badge_huge.svg",
    "no_template_3119.svg": "rec_laptop_card.svg",
    "no_template_3175.svg": "checker_result_badge.svg",
    "no_template_3188.svg": "checker_spec_icon.svg",
    "no_template_3299.svg": "checker_alert_warning.svg",
    "no_template_3361.svg": "checker_bg_pattern.svg",
    "no_template_3366.svg": "checker_info_dot.svg",
    "no_template_2587.svg": "ds_sample_icon.svg",
    "no_template_2699.svg": "ds_status_warning.svg"
}

copied_count = 0
for src_name, dst_name in mapping.items():
    src_path = os.path.join(src_dir, src_name)
    dst_path = os.path.join(dst_dir, dst_name)
    if os.path.exists(src_path):
        shutil.copy2(src_path, dst_path)
        print(f"Copied {src_name} -> {dst_name}")
        copied_count += 1
    else:
        print(f"Warning: {src_name} not found in {src_dir}")

print(f"\nTotal copied to {dst_dir}: {copied_count} files")
