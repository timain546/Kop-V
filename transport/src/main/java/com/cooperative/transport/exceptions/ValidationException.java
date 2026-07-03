package com.cooperative.transport.exceptions;

public class ValidationException extends RuntimeException {

    private String attr;
    private Object value;

    public ValidationException(String attr, Object value, String message) {
        super(message);
        this.attr = attr;
        this.value = value;
    }

    public String getAttr() { return attr; }
    public void setAttr(String attr) { this.attr = attr; }

    public Object getValue() { return value; }
    public void setValue(Object value) { this.value = value; }
}
