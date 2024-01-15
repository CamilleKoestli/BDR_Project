package photoz.models;

public class Statut {
    private String pseudo;
    private String pseudoart;
    private boolean typedemande; //suivre true     abonner false
    private boolean accepte_refus; //accepté true     refus false

    public Statut(boolean typedemande, boolean accepte_refus, String pseudoart, String pseudo) {
        this.pseudo = pseudo;
        this.pseudoart = pseudoart;
        this.typedemande = accepte_refus;
        this.accepte_refus = accepte_refus;
    }
}
