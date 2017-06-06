package com.i7colors.util;

import java.awt.*;
import java.awt.image.BufferedImage;

/**
 * 图片工具类
 */
public class ImageUtils {
	
	public static BufferedImage generateImgCode(String codeStr){
		BufferedImage img = new BufferedImage(96, 29, BufferedImage.TYPE_INT_RGB);
		// 得到该图片的绘图对象
		Graphics g = img.getGraphics();
		Color c = new Color(226, 226, 226);
		g.setColor(c);
		// 填充整个图片的颜色
		g.fillRect(0, 0, 96, 29);
		// 向图片中输出验证码
		char[] ch = codeStr.toCharArray();
		int  codeLength = codeStr.length();
		for (int i = 0; i < codeLength; i++) {
			g.setColor(new Color(27, 78, 181));
			g.setFont(new Font("Arial", Font.BOLD | Font.ITALIC, 20));// 输出的字体和大小
			g.drawString(""+ch[i], (i * 15) + 22, 22);// 写什么数字，在图片的什么位置画
		}
		return img;
		/*BufferedImage img = new BufferedImage(68, 22,BufferedImage.TYPE_INT_RGB);
		// 得到该图片的绘图对象
		Graphics g = img.getGraphics();
		Color c = new Color(244, 0, 8);
		g.setColor(c);
		// 填充整个图片的颜色
		g.fillRect(0, 0, 68, 22);
		// 向图片中输出验证码
		char[] ch = codeStr.toCharArray();
		int  codeLength = codeStr.length();
		for (int i = 0; i < codeLength; i++) {
			g.setColor(new Color(255, 255, 255));
			g.setFont(new Font("Arial", Font.BOLD | Font.ITALIC, 22));// 输出的字体和大小
			g.drawString(""+ch[i], (i * 15) + 3, 18);// 写什么数字，在图片的什么位置画
		}
		return img;*/
	}
}
