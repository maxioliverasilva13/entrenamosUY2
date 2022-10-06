/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Maximiliano Olivera
 */
public class BlobToImage {
    public String convert(byte[] blob) {
        String str = "";
        //read bytes from ByteArrayInputStream using read method
        if (blob != null && blob.length > 0) {
            for (byte b : blob) {
                str = str + (char) b;
            }
        }
        System.out.println(str);
        return str;
     }
    
    
    public String getBase64StringImage(byte[] imageBlob) {
        if (imageBlob == null) {
            return "https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png";
        }
        byte[] encoded = Base64.getEncoder().encode(imageBlob);
        String base64DataString = "";
        try {
            base64DataString = new String(encoded , "UTF-8");
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(BlobToImage.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "data:image/jpg;base64," + base64DataString;
    }
    
    
    
}
