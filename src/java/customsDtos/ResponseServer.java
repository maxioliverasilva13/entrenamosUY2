/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package customsDtos;

/**
 *
 * @author rodrigo
 */
public class ResponseServer {

    private int status;
    private String message;
    private Object data;

    public ResponseServer(int status, String message) {
        this.status = status;
        this.message = message;
    }

    public ResponseServer(int status, String message, Object data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }

    public Object getData() {
        return this.data;
    }

    public int getStatus() {
        return this.status;
    }

    public String getMessage() {
        return this.message;
    }

}
