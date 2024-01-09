--
-- Triggers
--

-- Mise à jour des badges en fonction des différentes actions
-- Trigger première photo postée
CREATE
    OR
    REPLACE FUNCTION badge_premiere_photo()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO "BadgeUtilisateur" (id_badge, pseudo)
    SELECT 1, NEW.pseudo
    WHERE NOT EXISTS (SELECT 1
                      FROM "BadgeUtilisateur" BU
                      WHERE BU.pseudo = NEW.pseudo);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_badge_premiere_photo
    AFTER INSERT
    ON "Photo"
    FOR EACH ROW
EXECUTE FUNCTION badge_premiere_photo();
--