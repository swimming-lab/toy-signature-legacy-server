package com.github.bestheroz.standard.common.util;

import lombok.experimental.UtilityClass;

import java.io.*;
import java.util.Base64;

@UtilityClass
public class SerializeUtils {

    public String serializeObjectToString(Object vo) {
        byte[] serializedObject = new byte[0];

        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ObjectOutputStream oos = new ObjectOutputStream(baos);
            oos.writeObject(vo);
            serializedObject = baos.toByteArray();
        } catch(IOException e) {
            e.printStackTrace();
        }

        return Base64.getEncoder().encodeToString(serializedObject);
    }

    public Object unserializeStringToObject(String str) {
        try {
            byte[] serializedMember = Base64.getDecoder().decode(str);
            ByteArrayInputStream bais = new ByteArrayInputStream(serializedMember);
            ObjectInputStream ois = new ObjectInputStream(bais);
            return ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }
}
