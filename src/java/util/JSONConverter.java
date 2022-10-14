package util;


import com.google.gson.Gson;
/**
* 
* @author Dinesh Krishnan
*
*/
public class JSONConverter {
    private static Gson gson = new Gson();
    public static String convert(Object object) {
        return gson.toJson(object);
    }
}
    