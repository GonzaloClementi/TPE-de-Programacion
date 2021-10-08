import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

public class fileManager {
	private String path;
	private int fileSize;
	public fileManager(String path) {
		this.path = path;
		this.fileSize=0;
	}
	private byte[] setArregloBtyes(List<Byte> list) {
		byte[] out = new byte[list.size()];
		for (int i = 0; i < list.size(); i++) {
			out[i] = list.get(i);
			this.fileSize++;
		}
		return out;
	}
	public void fileOut(List<Byte> writeList) throws IOException {
		DataOutputStream fileOut;
		fileOut = new DataOutputStream(new FileOutputStream(this.path));
		byte[] arrayB = setArregloBtyes(writeList);
		fileOut.write(arrayB);
		fileOut.close();
	}
	public int getFileSize(){
		return this.fileSize;
	}
}
