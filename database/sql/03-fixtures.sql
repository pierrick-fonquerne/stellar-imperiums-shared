BEGIN;

INSERT INTO utilisateur (
    pseudo, mail, mot_de_passe, role,
    necessaire_a_modifier, suspendu,
    date_inscription, derniere_connexion
) VALUES
    ('Cmdr_Vega',    'vega@stellar-imperiums.io',
     '$argon2id$v=19$m=65536,t=3,p=4$/vRsHuXykOEU7G0P2tAY8Q$nhmf8uoutCwmLzJQ1gCHY2Q7jTRoiLlUg3hWeWLH2mA',
     'joueur', FALSE, FALSE,
     NOW() - INTERVAL '120 days', NOW() - INTERVAL '1 hour'),

    ('StarLord42',   'starlord@stellar-imperiums.io',
     '$argon2id$v=19$m=65536,t=3,p=4$/vRsHuXykOEU7G0P2tAY8Q$nhmf8uoutCwmLzJQ1gCHY2Q7jTRoiLlUg3hWeWLH2mA',
     'joueur', FALSE, FALSE,
     NOW() - INTERVAL '90 days', NOW() - INTERVAL '6 hours'),

    ('NovaQueen',    'nova@stellar-imperiums.io',
     '$argon2id$v=19$m=65536,t=3,p=4$/vRsHuXykOEU7G0P2tAY8Q$nhmf8uoutCwmLzJQ1gCHY2Q7jTRoiLlUg3hWeWLH2mA',
     'joueur', FALSE, FALSE,
     NOW() - INTERVAL '75 days', NOW() - INTERVAL '12 hours'),

    ('HyperionX',    'hyperion@stellar-imperiums.io',
     '$argon2id$v=19$m=65536,t=3,p=4$/vRsHuXykOEU7G0P2tAY8Q$nhmf8uoutCwmLzJQ1gCHY2Q7jTRoiLlUg3hWeWLH2mA',
     'joueur', FALSE, FALSE,
     NOW() - INTERVAL '15 days', NOW() - INTERVAL '2 days'),

    ('RogueGalaxy',  'rogue@stellar-imperiums.io',
     '$argon2id$v=19$m=65536,t=3,p=4$/vRsHuXykOEU7G0P2tAY8Q$nhmf8uoutCwmLzJQ1gCHY2Q7jTRoiLlUg3hWeWLH2mA',
     'joueur', FALSE, FALSE,
     NOW() - INTERVAL '5 days', NOW() - INTERVAL '3 hours'),

    ('NebulaCorp',   'nebula@stellar-imperiums.io',
     '$argon2id$v=19$m=65536,t=3,p=4$/vRsHuXykOEU7G0P2tAY8Q$nhmf8uoutCwmLzJQ1gCHY2Q7jTRoiLlUg3hWeWLH2mA',
     'joueur', TRUE,  FALSE,
     NOW() - INTERVAL '45 days', NOW() - INTERVAL '2 days'),

    ('BlackHoleInc', 'blackhole@stellar-imperiums.io',
     '$argon2id$v=19$m=65536,t=3,p=4$/vRsHuXykOEU7G0P2tAY8Q$nhmf8uoutCwmLzJQ1gCHY2Q7jTRoiLlUg3hWeWLH2mA',
     'joueur', FALSE, TRUE,
     NOW() - INTERVAL '60 days', NOW() - INTERVAL '30 days'),

    ('StellarRider', 'rider@stellar-imperiums.io',
     '$argon2id$v=19$m=65536,t=3,p=4$/vRsHuXykOEU7G0P2tAY8Q$nhmf8uoutCwmLzJQ1gCHY2Q7jTRoiLlUg3hWeWLH2mA',
     'joueur', FALSE, FALSE,
     NOW() - INTERVAL '180 days', NOW() - INTERVAL '30 minutes');


INSERT INTO planete (nom, id_utilisateur, metal, cristal, energie, derniere_mise_a_jour)
SELECT data.nom, u.id_utilisateur, data.metal, data.cristal, data.energie, NOW()
FROM (VALUES
    ('Vega Prime',     'Cmdr_Vega',     42180.0000,  18420.0000,   6840.0000),
    ('Nova Terra',     'StarLord42',    28500.0000,  12300.0000,   4200.0000),
    ('Helios Station', 'NovaQueen',     18700.0000,   9400.0000,   3100.0000),
    ('Aurora',         'HyperionX',      4800.0000,   1900.0000,    850.0000),
    ('Proxima B',      'RogueGalaxy',    1200.0000,    640.0000,    420.0000),
    ('Andromeda',      'NebulaCorp',    15200.0000,   7800.0000,   2400.0000),
    ('Event Horizon',  'BlackHoleInc',  22000.0000,  11000.0000,   3800.0000),
    ('Orion Spur',     'StellarRider',  68400.0000,  31200.0000,  11600.0000)
) AS data(nom, pseudo, metal, cristal, energie)
JOIN utilisateur u ON u.pseudo = data.pseudo;


INSERT INTO batiment (id_planete, id_batiment_definition, niveau)
SELECT p.id_planete, bd.id_batiment_definition, data.niveau
FROM (VALUES
    ('Cmdr_Vega',     'mine_metal',           4),
    ('Cmdr_Vega',     'extracteur_cristal',   3),
    ('Cmdr_Vega',     'centrale_energetique', 5),
    ('Cmdr_Vega',     'entrepot',             2),
    ('Cmdr_Vega',     'silo_energetique',     1),
    ('StarLord42',    'mine_metal',           3),
    ('StarLord42',    'extracteur_cristal',   3),
    ('StarLord42',    'centrale_energetique', 4),
    ('StarLord42',    'entrepot',             1),
    ('NovaQueen',     'mine_metal',           3),
    ('NovaQueen',     'extracteur_cristal',   2),
    ('NovaQueen',     'centrale_energetique', 3),
    ('NovaQueen',     'entrepot',             1),
    ('HyperionX',     'mine_metal',           2),
    ('HyperionX',     'extracteur_cristal',   1),
    ('HyperionX',     'centrale_energetique', 2),
    ('RogueGalaxy',   'mine_metal',           1),
    ('RogueGalaxy',   'centrale_energetique', 1),
    ('NebulaCorp',    'mine_metal',           3),
    ('NebulaCorp',    'extracteur_cristal',   2),
    ('NebulaCorp',    'centrale_energetique', 3),
    ('BlackHoleInc',  'mine_metal',           4),
    ('BlackHoleInc',  'extracteur_cristal',   3),
    ('BlackHoleInc',  'centrale_energetique', 3),
    ('BlackHoleInc',  'entrepot',             2),
    ('StellarRider',  'mine_metal',           7),
    ('StellarRider',  'extracteur_cristal',   6),
    ('StellarRider',  'centrale_energetique', 8),
    ('StellarRider',  'entrepot',             4),
    ('StellarRider',  'silo_energetique',     3)
) AS data(pseudo, code_batiment, niveau)
JOIN utilisateur u          ON u.pseudo = data.pseudo
JOIN planete p              ON p.id_utilisateur = u.id_utilisateur
JOIN batiment_definition bd ON bd.code = data.code_batiment;


INSERT INTO recherche (id_utilisateur, id_recherche_definition, niveau)
SELECT u.id_utilisateur, rd.id_recherche_definition, data.niveau
FROM (VALUES
    ('Cmdr_Vega',    'metallurgie_avancee', 2),
    ('Cmdr_Vega',    'cristallographie',    1),
    ('Cmdr_Vega',    'techniques_stockage', 1),
    ('StarLord42',   'metallurgie_avancee', 2),
    ('StarLord42',   'fusion_nucleaire',    1),
    ('NovaQueen',    'metallurgie_avancee', 1),
    ('NovaQueen',    'cristallographie',    1),
    ('StellarRider', 'metallurgie_avancee', 5),
    ('StellarRider', 'cristallographie',    4),
    ('StellarRider', 'fusion_nucleaire',    5),
    ('StellarRider', 'techniques_stockage', 3),
    ('NebulaCorp',   'metallurgie_avancee', 1),
    ('BlackHoleInc', 'metallurgie_avancee', 2),
    ('BlackHoleInc', 'fusion_nucleaire',    1)
) AS data(pseudo, code_recherche, niveau)
JOIN utilisateur u           ON u.pseudo = data.pseudo
JOIN recherche_definition rd ON rd.code = data.code_recherche;


INSERT INTO file_construction (id_planete, type_element, niveau_cible, date_debut, date_fin)
SELECT p.id_planete, 'batiment', 5,
       NOW() - INTERVAL '15 minutes',
       NOW() + INTERVAL '42 minutes'
FROM planete p
JOIN utilisateur u ON u.id_utilisateur = p.id_utilisateur
WHERE u.pseudo = 'Cmdr_Vega';

INSERT INTO file_construction (id_planete, type_element, niveau_cible, date_debut, date_fin)
SELECT p.id_planete, 'recherche', 3,
       NOW() - INTERVAL '1 hour',
       NOW() + INTERVAL '3 hours 14 minutes'
FROM planete p
JOIN utilisateur u ON u.id_utilisateur = p.id_utilisateur
WHERE u.pseudo = 'Cmdr_Vega';

INSERT INTO file_construction (id_planete, type_element, niveau_cible, date_debut, date_fin)
SELECT p.id_planete, 'batiment', 4,
       NOW() - INTERVAL '30 minutes',
       NOW() + INTERVAL '1 hour 10 minutes'
FROM planete p
JOIN utilisateur u ON u.id_utilisateur = p.id_utilisateur
WHERE u.pseudo = 'StarLord42';

INSERT INTO file_construction (id_planete, type_element, niveau_cible, date_debut, date_fin)
SELECT p.id_planete, 'recherche', 6,
       NOW() - INTERVAL '2 hours',
       NOW() + INTERVAL '5 hours'
FROM planete p
JOIN utilisateur u ON u.id_utilisateur = p.id_utilisateur
WHERE u.pseudo = 'StellarRider';

COMMIT;
