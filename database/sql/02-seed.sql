BEGIN;

INSERT INTO batiment_definition (
    code, nom, description, type_production,
    base_cout_metal, base_cout_cristal, base_cout_energie,
    base_production_horaire, base_capacite_stockage, base_duree_secondes,
    multiplicateur_cout, multiplicateur_duree
) VALUES
    ('mine_metal',           'Mine de metal',
     'Extrait du metal directement depuis le sous-sol planetaire. Production continue, proportionnelle au niveau.',
     'metal',
     60,  15,  0,
     30,  NULL, 60,
     1.50, 1.40),

    ('extracteur_cristal',   'Extracteur de cristal',
     'Raffine le cristal brut extrait des gisements. La production requiert une consommation continue d''energie.',
     'cristal',
     48,  24,  0,
     15,  NULL, 80,
     1.60, 1.45),

    ('centrale_energetique', 'Centrale energetique',
     'Alimente l''ensemble des installations de la planete. Production limitee par la capacite des silos energetiques.',
     'energie',
     75,  30,  0,
     20,  NULL, 70,
     1.50, 1.40),

    ('entrepot',             'Entrepot',
     'Augmente la capacite maximale de stockage de metal et de cristal. Sans entrepot suffisant, la production est perdue.',
     'stockage_metal_cristal',
     1000, 0,   0,
     NULL, 10000, 300,
     2.00, 1.50),

    ('silo_energetique',     'Silo energetique',
     'Augmente la capacite maximale de stockage d''energie. Indispensable pour accumuler les reserves necessaires aux recherches longues.',
     'stockage_energie',
     1000, 500, 0,
     NULL, 5000, 300,
     2.00, 1.50);


INSERT INTO recherche_definition (
    code, nom, description, type_bonus, bonus_par_niveau,
    base_cout_metal, base_cout_cristal, base_cout_energie,
    base_duree_secondes, multiplicateur_cout, multiplicateur_duree
) VALUES
    ('metallurgie_avancee',  'Metallurgie avancee',
     'Optimise l''extraction et le traitement du metal. Augmente la production de metal de 5 % par niveau.',
     'production_metal', 0.0500,
     200, 100, 0,
     600, 2.00, 1.80),

    ('cristallographie',     'Cristallographie',
     'Ameliore les techniques de raffinage du cristal. Augmente la production de cristal de 5 % par niveau.',
     'production_cristal', 0.0500,
     200, 100, 0,
     600, 2.00, 1.80),

    ('fusion_nucleaire',     'Fusion nucleaire',
     'Optimise les reactions de fusion des centrales. Augmente la production d''energie de 5 % par niveau.',
     'production_energie', 0.0500,
     300, 150, 0,
     800, 2.00, 1.80),

    ('techniques_stockage',  'Techniques de stockage',
     'Ameliore l''efficacite des entrepots et des silos. Augmente la capacite de stockage globale de 10 % par niveau.',
     'capacite_stockage', 0.1000,
     500, 250, 0,
     1200, 2.00, 1.80);


INSERT INTO utilisateur (
    pseudo, mail, mot_de_passe,
    role, necessaire_a_modifier, suspendu,
    date_inscription
) VALUES (
    'admin',
    'admin@stellar-imperiums.io',
    '$argon2id$v=19$m=65536,t=3,p=4$0FCks4yDhpw2PqOmKg7FAw$EjBGRNLgHES+HUezNXUaQgZmM+Q/fFo2Uhnanx4DFEY',
    'admin', TRUE, FALSE,
    NOW()
);

COMMIT;
