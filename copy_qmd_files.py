import os
import shutil

def copy_qmd_files(src_dir, dst_dir):
    """Copy QMD files maintaining directory structure."""
    for root, dirs, files in os.walk(src_dir):
        # Skip _freeze and docs directories
        if '_freeze' in root or 'docs' in root:
            continue
            
        # Get relative path
        rel_path = os.path.relpath(root, src_dir)
        
        # Create corresponding directory in destination
        if rel_path != '.':
            dst_path = os.path.join(dst_dir, rel_path)
            os.makedirs(dst_path, exist_ok=True)
        else:
            dst_path = dst_dir
            
        # Copy QMD files
        for file in files:
            if file.endswith('.qmd'):
                src_file = os.path.join(root, file)
                dst_file = os.path.join(dst_path, file)
                shutil.copy2(src_file, dst_file)
                print(f'Copied: {dst_file}')

if __name__ == '__main__':
    src_dir = '.'
    dst_dir = 'friosa_edit'
    copy_qmd_files(src_dir, dst_dir)
    print('\nCopy complete!')