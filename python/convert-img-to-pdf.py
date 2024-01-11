# フォルダにある画像を全て結合します
# pip install img2pdf してください

import os

try:
  import img2pdf
except:
  print("'img2pdf' がインストールされていません。'pip install img2pdf' してください。")
  exit(0)

def convert_images_to_pdf(input_folder, output_pdf):
  # input_folderにある画像ファイルをリストアップ
  img_files = [f for f in os.listdir(input_folder) if f.endswith(('.png', '.jpg', '.jpeg'))]

  # 画像ファイルをimg2pdfを使用してPDFに変換
  with open(output_pdf, "wb") as file:
    images = sorted([os.path.join(input_folder, img) for img in img_files])
    file.write(img2pdf.convert(images))


if __name__ == "__main__":
  print("フォルダの中にある画像を全て結合したPDFを作成します。")
  input_path = input("結合したい画像が入ったフォルダの絶対パス : ")
  output_path = input("結合したPDFの配置場所の絶対パス : ")
  if input_path and output_path:
    convert_images_to_pdf(input_path, output_path)
    print(f"PDFを結合し、[{output_path}]に作成しました。")
  else:
    print("パスが入力されていません。")