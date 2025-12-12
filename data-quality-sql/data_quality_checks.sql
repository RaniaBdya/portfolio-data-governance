-- 1. Emails manquants
SELECT *
FROM clients
WHERE email IS NULL OR email = '';

-- 2. Pays manquant
SELECT *
FROM clients
WHERE pays IS NULL OR pays = '';

-- 3. Abonnements liés à un client inexistant
SELECT a.*
FROM abonnements a
LEFT JOIN clients c ON a.id_client = c.id_client
WHERE c.id_client IS NULL;

-- 4. Paiements liés à un abonnement inexistant
SELECT p.*
FROM paiements p
LEFT JOIN abonnements a ON p.id_abonnement = a.id_abonnement
WHERE a.id_abonnement IS NULL;

-- 5. Emails au mauvais format
SELECT *
FROM clients
WHERE email NOT LIKE '%@%.%';

-- 6. Dates de fin incohérentes (date_fin < date_debut)
SELECT *
FROM abonnements
WHERE date_fin < date_debut;

-- 7. Doublons potentiels sur email
SELECT email, COUNT(*) AS nb
FROM clients
GROUP BY email
HAVING COUNT(*) > 1;

-- 8. Statuts de paiement inconnus
SELECT DISTINCT statut_paiement
FROM paiements
WHERE statut_paiement NOT IN ('SUCCESS', 'FAILED', 'PENDING');

-- 9. Montants négatifs
SELECT *
FROM paiements
WHERE montant < 0;

-- 10. Répartition clients par pays
SELECT pays, COUNT(*) AS nb_clients
FROM clients
GROUP BY pays
ORDER BY nb_clients DESC
LIMIT 10;
