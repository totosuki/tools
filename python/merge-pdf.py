# ２つの PDF を結合します
# pip install pypdf してください

try:
  from pypdf import PdfMerger
except:
  print("'pypdf' がインストールされていません。'pip install pypdf' してください。")
  exit(0)

def merge_pdf(merger: PdfMerger, merge_cnt: int):
  for i in range(1, merge_cnt + 1):
    path = input(f"{i}個目のPDFのパス : ")
    merger.append(path)
  pdf_path = input("結合したPDFの配置場所 : ")
  merger.write(pdf_path)
  merger.close()

def main():
  merger = PdfMerger()
  merge_cnt = int(input("結合するPDFの数 : "))
  merge_pdf(merger, merge_cnt)

if __name__ == "__main__":
  main()