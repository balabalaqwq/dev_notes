    `/**
     * 工具方法
     * 为Byte数组添加两位CRC校验
     * @param buf
     * @return
     */
    public static byte[] setParamCRC(byte[] buf) {
        int len = buf.length;

        // 预置 1 个 16 位的寄存器为十六进制FFFF, 称此寄存器为 CRC寄存器。
        int crc = 0xFFFF;
        int i, j;
        for (i = 0; i < len; i++) {
            // 把第一个 8 位二进制数据 与 16 位的 CRC寄存器的低 8 位相异或, 把结果放于 CRC寄存器
            crc = ((crc & 0xFF00) | (crc & 0x00FF) ^ (buf[i] & 0xFF));
            for (j = 0; j < 8; j++) {
                // 把 CRC 寄存器的内容右移一位( 朝低位)用 0 填补最高位, 并检查右移后的移出位
                if ((crc & 0x0001) > 0) {
                    // 如果移出位为 1, CRC寄存器与多项式A001进行异或
                    crc = crc >> 1;
                    crc = crc ^ 0xA001;
                } else
                    // 如果移出位为 0,再次右移一位
                    crc = crc >> 1;
            }
        }
        byte[] src = new byte[2];
        src[0] =  (byte) ((crc>>8) & 0xFF);
        src[1] =  (byte) (crc & 0xFF);
        // 将新生成的byte数组添加到原数据结尾并返回
        return concatAll(buf, src);
    }`

    `/**
     * 工具方法
     * 验证是否通过CRC校验
     * @param buf
     * @return true false
     */
    public boolean isPassCRC(byte[] bytes) {
        byte[] buf = subBytes(bytes, 0, bytes.length-2);
        int len = buf.length;

        // 预置 1 个 16 位的寄存器为十六进制FFFF, 称此寄存器为 CRC寄存器。
        int crc = 0xFFFF;
        int i, j;
        for (i = 0; i < len; i++) {
            // 把第一个 8 位二进制数据 与 16 位的 CRC寄存器的低 8 位相异或, 把结果放于 CRC寄存器
            crc = ((crc & 0xFF00) | (crc & 0x00FF) ^ (buf[i] & 0xFF));
            for (j = 0; j < 8; j++) {
                // 把 CRC 寄存器的内容右移一位( 朝低位)用 0 填补最高位, 并检查右移后的移出位
                if ((crc & 0x0001) > 0) {
                    // 如果移出位为 1, CRC寄存器与多项式A001进行异或
                    crc = crc >> 1;
                    crc = crc ^ 0xA001;
                } else
                    // 如果移出位为 0,再次右移一位
                    crc = crc >> 1;
            }
        }
        byte[] src = new byte[2];
        src[0] =  (byte) ((crc>>8) & 0xFF);
        src[1] =  (byte) (crc & 0xFF);
        Log.d(TAG, "CRC校验数据： " + "flag:" + String.valueOf(flag) + " 1bytes: " + bytesToHex(bytes) + "  2crc验证: " + bytesToHex(concatAll(buf, src)));
        Log.d(TAG, "CRC校验数据： " + "return:" + String.valueOf(Arrays.equals(bytes,concatAll(buf, src))));
        // 将新生成的byte数组添加到原数据结尾并返回
        return Arrays.equals(bytes,concatAll(buf, src));
    }`    
    
   
    
    `/**
     * 工具方法
     * 将byte数组转换成十六进制字符串
     */
    private static char[] hexArray = "0123456789ABCDEF".toCharArray();
    public static String bytesToHex(byte[] paramArrayOfbyte) {
        char[] arrayOfChar = new char[paramArrayOfbyte.length * 2];
        for (int i = 0; i < paramArrayOfbyte.length; i++) {
            int j = paramArrayOfbyte[i] & 0xFF;
            int k = i * 2;
            char[] arrayOfChar1 = hexArray;
            arrayOfChar[k] = arrayOfChar1[j >>> 4];
            arrayOfChar[k + 1] = arrayOfChar1[j & 0xF];
        }
        return new String(arrayOfChar);
    }`

   ` /**
     * 工具方法
     * 多个数组合并
     * @param first
     * @param rest
     * @return
     */
    @TargetApi(Build.VERSION_CODES.GINGERBREAD)
    public static byte[] concatAll(byte[] first, byte[]... rest) {
        int totalLength = first.length;
        for (byte[] array : rest) {
            totalLength += array.length;
        }
        byte[] result = Arrays.copyOf(first, totalLength);
        int offset = first.length;
        for (byte[] array : rest) {
            System.arraycopy(array, 0, result, offset, array.length);
            offset += array.length;
        }
        return result;
    }`
    
    `/**
     * 工具方法
     * @description: 截取数据长度
     * @param src begin(起始位置) count(长度)
     * @return byte[]
     * @author wt
     * @date 2022/12/25 16:40
     */
    public static byte[] subBytes(byte[]src,int begin,int count){
        byte[]bs=new byte[count];
        for(int i=begin;i<begin+count;i++){
            bs[i-begin]=src[i];
        }
        return bs;
    }`
