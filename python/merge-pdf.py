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
  print("結合したPDFのパスを入力してください。例 : /Users/username/Desktop/test.pdf")
  pdf_path = input("結合したPDFのパス : ")
  merger.write(pdf_path)
  merger.close()

def main():
  merger = PdfMerger()
  merge_cnt = input("結合するPDFの数 : ")
  if not merge_cnt:
    print("結合するPDFの数を入力してください。")
    exit(0)
  elif int(merge_cnt) == 0:
    print("結合するPDFの数が0です。")
    exit(0)
  else:
    print("PDFの結合を開始します。")
    merge_pdf(merger, int(merge_cnt))

if __name__ == "__main__":
  main()