import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class check {
    public static void main(String args[]){
        File file = new File("vector_output.out");
        File file2 = new File("vector_result.out");
        BufferedReader reader = null;
        BufferedReader reader2 = null;
        try {
            reader = new BufferedReader(new FileReader(file));
            reader2 = new BufferedReader(new FileReader(file2));
            String tempString = null;
            String tempString2 = null;
            int line = 1;
            while (line <= 10) {
                tempString = reader.readLine();
                tempString2 = reader2.readLine();
                boolean judge = true;
                for(int i = 0; i < tempString2.length(); i++){
                    if(tempString2.charAt(i) != tempString.charAt(i)){
                        judge = false;
                    }
                }
                if(judge){
                    System.out.println("The result of " + line + " pass is correct");
                }else{
                    System.out.println("The result of " + line + " pass is wrong");
                }
                line++;
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }
    }
}
