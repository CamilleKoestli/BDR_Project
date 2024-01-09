package photoz.models;

public class Statut {
    private String pseudo;
    private String pseudoArt;
    private boolean typedemande; //suivre true     abonner false
    private boolean accepte_refus; //accepté true     refus false

    public Statut(boolean typedemande, boolean accepte_refus, String pseudoArt, String pseudo) {
        this.pseudo = pseudo;
        this.pseudoArt = pseudoArt;
        this.typedemande = accepte_refus;
        this.accepte_refus = accepte_refus;
    }
}
