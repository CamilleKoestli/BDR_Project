package photoz.models;

public class Photo {
    public int id;
    public String title;
    public String pseudo;
    public String path;

    public Photo( int id, String title, String pseudo, String path){
        this.id = id;
        this.title = title;
        this.pseudo = pseudo;
        this.path = path;
    }

}
