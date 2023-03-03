package cn.mvc.tools;

import org.slf4j.LoggerFactory;
import org.slf4j.Logger;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public class SerializeUtil {
    private static Logger logger = LoggerFactory.getLogger(SerializeUtil.class);

    public static byte[] serialize(Object object) {
        ObjectOutputStream oos = null;
        ByteArrayOutputStream baos = null;
        try {
            baos = new ByteArrayOutputStream();
            oos = new ObjectOutputStream(baos);
            oos.writeObject(object);
            byte[] bytes = baos.toByteArray();
            oos.close();
            return bytes;
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }
        return null;
    }

    public static Object unSerialize(byte[] bytes) {
        ByteArrayInputStream bais = null;
        try {
            bais = new ByteArrayInputStream(bytes);
            ObjectInputStream ois = new ObjectInputStream(bais);
            return ois.readObject();
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }
        return null;
    }

}
