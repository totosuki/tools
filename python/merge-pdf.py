# ２つの PDF を結合します
# pip install pypdf してください

import pypdf
merger = pypdf.PdfMerger()
PATH1 = input("PATH1: ")       # 一つ目の PDF のパス
PATH2 = input("PATH2: ")       # 二つ目の PDF のパス
PDF_PATH = input("PDF_PATH: ") # 結合した PDF のパス
merger.append(PATH1)
merger.append(PATH2)
merger.write(PDF_PATH)
merger.close()