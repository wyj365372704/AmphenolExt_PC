package com.amphenol.util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import javax.imageio.ImageIO;

import com.swetake.util.Qrcode;

public class QRcoderUtil {
	
	public static String encoderQRCoder(String content, String userName,String path) {
		String result = "";
		File file = null ;
		try {
			Qrcode handler = new Qrcode();
			int base = 5; //1 -40
			handler.setQrcodeVersion(base);
			byte[] contentBytes = content.getBytes("UTF-8");
			 int imgSize = 67 + 12 * (base - 1);
			BufferedImage bufImg = new BufferedImage(imgSize, imgSize, BufferedImage.TYPE_INT_RGB);
			
			Graphics2D gs = bufImg.createGraphics();
			
			gs.setBackground(Color.WHITE);
			gs.clearRect(0, 0, imgSize, imgSize);
			
			//设定图像颜色：BLACK
			gs.setColor(Color.BLACK);
			
			//设置偏移量  不设置肯能导致解析出错
			int pixoff = 2;
			//输出内容：二维码
			if(contentBytes.length > 0) {
				boolean[][] codeOut = handler.calQrcode(contentBytes);
				for(int i = 0; i < codeOut.length; i++) {
					for(int j = 0; j < codeOut.length; j++) {
						if(codeOut[j][i]) {
							gs.fillRect(j * 3 + pixoff, i * 3 + pixoff,3, 3);
						}
					}
				}
			} else {
				System.err.println("QRCode content bytes length = " + contentBytes.length + " not in [ 0,120 ]. ");
			}
			
			gs.dispose();
			bufImg.flush();
			File file2 = new File(path+"/QRImages");
			if(!file2.exists()){
				file2.mkdirs();
			}
			
			String fileName=userName.trim()+System.currentTimeMillis()+".jpg";
			file = new File(file2,fileName);
			OutputStream os = new FileOutputStream(file);
			
			//生成二维码QRCode图片
			ImageIO.write(bufImg, "jpg", os);
			os.flush();
			os.close();
			result = "QRImages/"+file.getName();
		} catch (Exception e) {
			if(file != null && file.exists())
				file.delete();
			e.printStackTrace();
		}
		return result ;
	}
}
