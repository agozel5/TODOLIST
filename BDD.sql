CREATE TABLE USER (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(40) NOT NULL,
    prenom VARCHAR(40) NOT NULL,
    mail VARCHAR(120) NOT NULL,
    username VARCHAR(40) NOT NULL,
    mdp VARCHAR(120) NOT NULL,
    otp_enabled TINYINT(1) DEFAULT 0,
    otp_secret VARCHAR(32)
);

CREATE TABLE GROUPE (
    id_groupe INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(60) NOT NULL,
    synchro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_user INT,
    date_creation DATETIME DEFAULT CURRENT_TIMESTAMP,
    permissions INT DEFAULT 0,
    FOREIGN KEY (id_user) REFERENCES USER(id_user)
);

CREATE TABLE DOSSIER (
    id_dossier INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(60) NOT NULL,
    id_groupe INT,
    FOREIGN KEY (id_groupe) REFERENCES GROUPE(id_groupe)
);

CREATE TABLE TACHES (
    id_tache INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(60) NOT NULL,
    sous_titre VARCHAR(60),
    texte VARCHAR(200),
    commentaire VARCHAR(200),
    date_debut TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_fin TIMESTAMP,
    priorite INT,
    statut INT DEFAULT 0,
    id_dossier INT,
    id_user INT,
    FOREIGN KEY (id_dossier) REFERENCES DOSSIER(id_dossier),
    FOREIGN KEY (id_user) REFERENCES USER(id_user)
);

CREATE TABLE DROIT (
    id_droit INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT,
    id_tache INT,
    droit INT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES USER(id_user),
    FOREIGN KEY (id_tache) REFERENCES TACHES(id_tache)
);

CREATE TABLE ETIQUETTES (
    id_etiquettes INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(300) NOT NULL
);

CREATE TABLE TACHE_ETIQUETTE (
    id_tache INT,
    id_etiquettes INT,
    PRIMARY KEY (id_tache, id_etiquettes),
    FOREIGN KEY (id_tache) REFERENCES TACHES(id_tache),
    FOREIGN KEY (id_etiquettes) REFERENCES ETIQUETTES(id_etiquettes)
);

CREATE TABLE INVITATION (
    id_invitation INT AUTO_INCREMENT PRIMARY KEY,
    id_groupe INT,
    id_user INT,
    statut VARCHAR(20) DEFAULT 'En attente',
    FOREIGN KEY (id_groupe) REFERENCES GROUPE(id_groupe),
    FOREIGN KEY (id_user) REFERENCES USER(id_user)
);

CREATE TABLE MEMBRE (
    id_membre INT AUTO_INCREMENT PRIMARY KEY,
    id_groupe INT,
    id_user INT,
    role ENUM('admin', 'lecture', 'éditeur') DEFAULT 'lecture',
    FOREIGN KEY (id_groupe) REFERENCES GROUPE(id_groupe),
    FOREIGN KEY (id_user) REFERENCES USER(id_user)
);

CREATE TABLE HISTORIQUE (
    id_historique INT AUTO_INCREMENT PRIMARY KEY,
    id_tache INT,
    id_user INT,
    action VARCHAR(255),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tache) REFERENCES TACHES(id_tache),
    FOREIGN KEY (id_user) REFERENCES USER(id_user)
);

CREATE TABLE SOUS_TACHES (
    id_sous_tache INT AUTO_INCREMENT PRIMARY KEY,
    id_tache INT,
    titre VARCHAR(255),
    priorite INT,
    date_fin DATE,
    statut INT,
    FOREIGN KEY (id_tache) REFERENCES TACHES(id_tache)
);

CREATE TABLE COMMENTAIRES (
    id_commentaire INT AUTO_INCREMENT PRIMARY KEY,
    id_tache INT,
    id_user INT,
    commentaire TEXT,
    date_commentaire TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tache) REFERENCES TACHES(id_tache),
    FOREIGN KEY (id_user) REFERENCES USER(id_user)
);
