List<Map<String, dynamic>> exemplesMaladiesChroniques = [
  {
    'id': 'disease1',
    'patientId': 'patient1',
    'name': 'Diabète de type 1',
    'description':
        'Maladie chronique où le pancréas ne produit pas d\'insuline.',
    'symptoms': ['Soif excessive', 'Mictions fréquentes', 'Fatigue'],
    'treatments': ['Insuline', 'Régime alimentaire', 'Exercice physique'],
    'type': 'Chronique',
    'status': 'Active',
    'level': 'Sévère',
  },
  {
    'id': 'disease2',
    'patientId': 'patient2',
    'name': 'Hypertension',
    'description': 'Pression sanguine élevée persistante.',
    'symptoms': ['Maux de tête', 'Vertiges', 'Essoufflement'],
    'treatments': [
      'Médicaments antihypertenseurs',
      'Régime alimentaire',
      'Exercice physique'
    ],
    'type': 'Chronique',
    'status': 'Active',
    'level': 'Modérée',
  },
  {
    'id': 'disease3',
    'patientId': 'patient3',
    'name': 'Asthme',
    'description':
        'Maladie respiratoire chronique caractérisée par une inflammation des voies respiratoires.',
    'symptoms': ['Toux', 'Sifflements', 'Essoufflement'],
    'treatments': ['Inhalateurs', 'Corticostéroïdes', 'Bronchodilatateurs'],
    'type': 'Chronique',
    'status': 'Active',
    'level': 'Modérée',
  },
  {
    'id': 'disease4',
    'patientId': 'patient4',
    'name': 'Arthrite rhumatoïde',
    'description':
        'Maladie auto-immune causant une inflammation des articulations.',
    'symptoms': ['Douleur articulaire', 'Gonflement', 'Raideur'],
    'treatments': [
      'Anti-inflammatoires',
      'Physiothérapie',
      'Immunosuppresseurs'
    ],
    'type': 'Chronique',
    'status': 'Active',
    'level': 'Sévère',
  },
  {
    'id': 'disease5',
    'patientId': 'patient5',
    'name': 'Maladie de Crohn',
    'description': 'Maladie inflammatoire chronique de l\'intestin.',
    'symptoms': ['Douleur abdominale', 'Diarrhée', 'Fatigue'],
    'treatments': ['Anti-inflammatoires', 'Immunosuppresseurs', 'Chirurgie'],
    'type': 'Chronique',
    'status': 'Active',
    'level': 'Sévère',
  },
  {
    'id': 'disease6',
    'patientId': 'patient6',
    'name': 'Maladie de Parkinson',
    'description': 'Maladie neurodégénérative affectant le mouvement.',
    'symptoms': [
      'Tremblements',
      'Rigidité musculaire',
      'Lenteur des mouvements'
    ],
    'treatments': [
      'Médicaments dopaminergiques',
      'Thérapie physique',
      'Chirurgie'
    ],
    'type': 'Chronique',
    'status': 'Active',
    'level': 'Sévère',
  },
  {
    'id': 'disease7',
    'patientId': 'patient7',
    'name': 'Insuffisance cardiaque congestive',
    'description': 'Incapacité du cœur à pomper suffisamment de sang.',
    'symptoms': ['Essoufflement', 'Fatigue', 'Gonflement des jambes'],
    'treatments': ['Médicaments', 'Chirurgie', 'Modifications du mode de vie'],
    'type': 'Chronique',
    'status': 'Active',
    'level': 'Sévère',
  },
  {
    'id': 'disease8',
    'patientId': 'patient8',
    'name': 'Insuffisance rénale chronique',
    'description': 'Détérioration progressive de la fonction rénale.',
    'symptoms': ['Nausées', 'Fatigue', 'Œdème'],
    'treatments': ['Dialyse', 'Transplantation rénale', 'Médicaments'],
    'type': 'Chronique',
    'status': 'Active',
    'level': 'Sévère',
  },
  {
    'id': 'disease9',
    'patientId': 'patient9',
    'name': 'Bronchopneumopathie chronique obstructive (BPCO)',
    'description': 'Maladie pulmonaire obstructive chronique.',
    'symptoms': ['Essoufflement', 'Toux chronique', 'Production de mucus'],
    'treatments': ['Bronchodilatateurs', 'Corticostéroïdes', 'Oxygénothérapie'],
    'type': 'Chronique',
    'status': 'Active',
    'level': 'Modérée',
  },
  {
    'id': 'disease10',
    'patientId': 'patient10',
    'name': 'Sclérose en plaques',
    'description': 'Maladie auto-immune affectant le système nerveux central.',
    'symptoms': ['Fatigue', 'Troubles de la vision', 'Faiblesse musculaire'],
    'treatments': [
      'Immunosuppresseurs',
      'Physiothérapie',
      'Médicaments symptomatiques'
    ],
    'type': 'Chronique',
    'status': 'Active',
    'level': 'Modérée',
  }
];
List<Map<String, dynamic>> exemplesMaladiesGenerales = [
  {
    'id': 'disease1',
    'patientId': 'patient1',
    'name': 'Grippe',
    'description': 'Infection virale qui attaque les voies respiratoires.',
    'symptoms': ['Fièvre', 'Toux', 'Douleurs musculaires'],
    'treatments': ['Repos', 'Hydratation', 'Médicaments antiviraux'],
    'type': 'Virale',
    'status': 'Active',
    'level': 'Modérée',
  },
  {
    'id': 'disease2',
    'patientId': 'patient2',
    'name': 'Rhume',
    'description':
        'Infection virale bénigne des voies respiratoires supérieures.',
    'symptoms': ['Écoulement nasal', 'Éternuements', 'Maux de gorge'],
    'treatments': ['Repos', 'Hydratation', 'Médicaments en vente libre'],
    'type': 'Virale',
    'status': 'Active',
    'level': 'Légère',
  },
  {
    'id': 'disease3',
    'patientId': 'patient3',
    'name': 'Gastro-entérite',
    'description': 'Inflammation du tractus gastro-intestinal.',
    'symptoms': ['Diarrhée', 'Nausées', 'Vomissements'],
    'treatments': ['Hydratation', 'Régime alimentaire léger', 'Médicaments'],
    'type': 'Virale ou bactérienne',
    'status': 'Active',
    'level': 'Modérée',
  },
  {
    'id': 'disease4',
    'patientId': 'patient4',
    'name': 'Otite',
    'description': 'Infection de l\'oreille moyenne.',
    'symptoms': ['Douleur auriculaire', 'Fièvre', 'Perte d\'audition'],
    'treatments': ['Antibiotiques', 'Analgésiques', 'Gouttes auriculaires'],
    'type': 'Bactérienne',
    'status': 'Active',
    'level': 'Légère',
  },
  {
    'id': 'disease5',
    'patientId': 'patient5',
    'name': 'Conjonctivite',
    'description': 'Inflammation ou infection de la conjonctive.',
    'symptoms': ['Rougeur', 'Démangeaisons', 'Écoulement'],
    'treatments': [
      'Gouttes ophtalmiques',
      'Compresses chaudes',
      'Antibiotiques'
    ],
    'type': 'Virale ou bactérienne',
    'status': 'Active',
    'level': 'Modérée',
  },
  {
    'id': 'disease6',
    'patientId': 'patient6',
    'name': 'Angine streptococcique',
    'description':
        'Infection bactérienne de la gorge causée par Streptococcus pyogenes.',
    'symptoms': [
      'Mal de gorge sévère',
      'Fièvre',
      'Ganglions lymphatiques enflés'
    ],
    'treatments': ['Antibiotiques', 'Analgésiques', 'Repos'],
    'type': 'Bactérienne',
    'status': 'Active',
    'level': 'Sévère',
  },
  {
    'id': 'disease7',
    'patientId': 'patient7',
    'name': 'Pneumonie',
    'description':
        'Infection des poumons causée par des bactéries, des virus ou des champignons.',
    'symptoms': ['Toux', 'Fièvre', 'Essoufflement'],
    'treatments': ['Antibiotiques', 'Antiviraux', 'Oxygénothérapie'],
    'type': 'Bactérienne, virale ou fongique',
    'status': 'Active',
    'level': 'Sévère',
  },
  {
    'id': 'disease8',
    'patientId': 'patient8',
    'name': 'Sinusite',
    'description': 'Inflammation ou infection des sinus paranasaux.',
    'symptoms': ['Congestion nasale', 'Douleur faciale', 'Maux de tête'],
    'treatments': ['Décongestionnants', 'Antibiotiques', 'Analgesiques'],
    'type': 'Virale ou bactérienne',
    'status': 'Active',
    'level': 'Modérée',
  },
  {
    'id': 'disease9',
    'patientId': 'patient9',
    'name': 'Bronchite',
    'description':
        'Inflammation des bronches, souvent due à une infection virale.',
    'symptoms': ['Toux', 'Production de mucus', 'Essoufflement'],
    'treatments': ['Repos', 'Hydratation', 'Bronchodilatateurs'],
    'type': 'Virale',
    'status': 'Active',
    'level': 'Modérée',
  },
  {
    'id': 'disease10',
    'patientId': 'patient10',
    'name': 'Cystite',
    'description': 'Infection de la vessie causée par des bactéries.',
    'symptoms': [
      'Douleur ou brûlure pendant la miction',
      'Urines troubles',
      'Besoin fréquent d\'uriner'
    ],
    'treatments': ['Antibiotiques', 'Hydratation', 'Analgésiques'],
    'type': 'Bactérienne',
    'status': 'Active',
    'level': 'Modérée',
  }
];
List<Map<String, dynamic>> exemplesAllergies = [
  {
    'id': 'allergy1',
    'patientId': 'patient1',
    'name': 'Pollen',
    'description': 'Réaction allergique au pollen des plantes.',
    'symptoms': ['Éternuements', 'Démangeaisons des yeux', 'Congestion nasale'],
    'treatments': ['Antihistaminiques', 'Décongestionnants', 'Immunothérapie'],
    'type': 'Environnementale',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy2',
    'patientId': 'patient2',
    'name': 'Poussière',
    'description': 'Réaction allergique aux acariens dans la poussière.',
    'symptoms': ['Éternuements', 'Toux', 'Démangeaisons'],
    'treatments': [
      'Nettoyage régulier',
      'Antihistaminiques',
      'Décongestionnants'
    ],
    'type': 'Environnementale',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy3',
    'patientId': 'patient3',
    'name': 'Poils d\'animaux',
    'description': 'Réaction allergique aux poils d\'animaux domestiques.',
    'symptoms': ['Éternuements', 'Démangeaisons', 'Écoulement nasal'],
    'treatments': ['Antihistaminiques', 'Immunothérapie', 'Éviter le contact'],
    'type': 'Environnementale',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy4',
    'patientId': 'patient4',
    'name': 'Moisissure',
    'description': 'Réaction allergique aux spores de moisissures.',
    'symptoms': ['Congestion nasale', 'Toux', 'Respiration sifflante'],
    'treatments': ['Antihistaminiques', 'Décongestionnants', 'Immunothérapie'],
    'type': 'Environnementale',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy5',
    'patientId': 'patient5',
    'name': 'Noix',
    'description': 'Réaction allergique aux noix.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': ['Éviter les noix', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Alimentaire',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy6',
    'patientId': 'patient6',
    'name': 'Arachides',
    'description': 'Réaction allergique aux arachides.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': ['Éviter les arachides', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Alimentaire',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy7',
    'patientId': 'patient7',
    'name': 'Fruits de mer',
    'description': 'Réaction allergique aux fruits de mer.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': [
      'Éviter les fruits de mer',
      'Antihistaminiques',
      'Épinéphrine'
    ],
    'type': 'Alimentaire',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy8',
    'patientId': 'patient8',
    'name': 'Lait',
    'description': 'Réaction allergique aux protéines du lait de vache.',
    'symptoms': ['Urticaire', 'Douleurs abdominales', 'Anaphylaxie'],
    'treatments': [
      'Éviter les produits laitiers',
      'Antihistaminiques',
      'Épinéphrine'
    ],
    'type': 'Alimentaire',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy9',
    'patientId': 'patient9',
    'name': 'Oeufs',
    'description': 'Réaction allergique aux protéines présentes dans les œufs.',
    'symptoms': ['Urticaire', 'Douleurs abdominales', 'Anaphylaxie'],
    'treatments': ['Éviter les œufs', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Alimentaire',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy10',
    'patientId': 'patient10',
    'name': 'Soja',
    'description': 'Réaction allergique aux protéines de soja.',
    'symptoms': ['Urticaire', 'Douleurs abdominales', 'Anaphylaxie'],
    'treatments': ['Éviter le soja', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Alimentaire',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy11',
    'patientId': 'patient11',
    'name': 'Blé',
    'description': 'Réaction allergique aux protéines de blé.',
    'symptoms': ['Urticaire', 'Douleurs abdominales', 'Anaphylaxie'],
    'treatments': ['Éviter le blé', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Alimentaire',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy12',
    'patientId': 'patient12',
    'name': 'Gluten',
    'description': 'Réaction allergique ou sensibilité au gluten.',
    'symptoms': ['Douleurs abdominales', 'Ballonnements', 'Diarrhée'],
    'treatments': ['Éviter le gluten', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Alimentaire',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy13',
    'patientId': 'patient13',
    'name': 'Piqûres d\'insectes',
    'description': 'Réaction allergique aux piqûres d\'insectes.',
    'symptoms': ['Douleur', 'Gonflement', 'Anaphylaxie'],
    'treatments': ['Éviter les insectes', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Environnementale',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy14',
    'patientId': 'patient14',
    'name': 'Pénicilline',
    'description': 'Réaction allergique à la pénicilline.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': ['Éviter la pénicilline', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy15',
    'patientId': 'patient15',
    'name': 'Ibuprofène',
    'description': 'Réaction allergique à l\'ibuprofène.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': ['Éviter l\'ibuprofène', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy16',
    'patientId': 'patient16',
    'name': 'Aspirine',
    'description': 'Réaction allergique à l\'aspirine.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': ['Éviter l\'aspirine', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy17',
    'patientId': 'patient17',
    'name': 'Amoxicilline',
    'description': 'Réaction allergique à l\'amoxicilline.',
    'symptoms': ['Urticaire', 'Éruptions cutanées', 'Anaphylaxie'],
    'treatments': [
      'Éviter l\'amoxicilline',
      'Antihistaminiques',
      'Épinéphrine'
    ],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy18',
    'patientId': 'patient18',
    'name': 'Antibiotiques sulfonamides',
    'description': 'Réaction allergique aux antibiotiques sulfonamides.',
    'symptoms': ['Éruptions cutanées', 'Fièvre', 'Anaphylaxie'],
    'treatments': [
      'Éviter les sulfonamides',
      'Antihistaminiques',
      'Épinéphrine'
    ],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy19',
    'patientId': 'patient19',
    'name': 'Naproxène',
    'description': 'Réaction allergique au naproxène.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': ['Éviter le naproxène', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy20',
    'patientId': 'patient20',
    'name': 'Céphalexine',
    'description': 'Réaction allergique à la céphalexine.',
    'symptoms': ['Urticaire', 'Éruptions cutanées', 'Anaphylaxie'],
    'treatments': ['Éviter la céphalexine', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy21',
    'patientId': 'patient21',
    'name': 'Tramadol',
    'description': 'Réaction allergique au tramadol.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': ['Éviter le tramadol', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy22',
    'patientId': 'patient22',
    'name': 'Oxicodone',
    'description': 'Réaction allergique à l\'oxicodone.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': ['Éviter l\'oxicodone', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy23',
    'patientId': 'patient23',
    'name': 'Morphine',
    'description': 'Réaction allergique à la morphine.',
    'symptoms': ['Urticaire', 'Éruptions cutanées', 'Anaphylaxie'],
    'treatments': ['Éviter la morphine', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy24',
    'patientId': 'patient24',
    'name': 'Insuline',
    'description': 'Réaction allergique à l\'insuline.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': [
      'Éviter certains types d\'insuline',
      'Antihistaminiques',
      'Épinéphrine'
    ],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy25',
    'patientId': 'patient25',
    'name': 'Vaccins',
    'description': 'Réaction allergique à certains vaccins.',
    'symptoms': ['Urticaire', 'Éruptions cutanées', 'Anaphylaxie'],
    'treatments': [
      'Éviter certains vaccins',
      'Antihistaminiques',
      'Épinéphrine'
    ],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy26',
    'patientId': 'patient26',
    'name': 'Chimiothérapie',
    'description': 'Réaction allergique à certains agents de chimiothérapie.',
    'symptoms': ['Éruptions cutanées', 'Fièvre', 'Anaphylaxie'],
    'treatments': [
      'Éviter certains agents',
      'Antihistaminiques',
      'Épinéphrine'
    ],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy27',
    'patientId': 'patient27',
    'name': 'Anesthésie',
    'description': 'Réaction allergique à certains anesthésiques.',
    'symptoms': ['Urticaire', 'Gonflement', 'Anaphylaxie'],
    'treatments': [
      'Éviter certains anesthésiques',
      'Antihistaminiques',
      'Épinéphrine'
    ],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  },
  {
    'id': 'allergy28',
    'patientId': 'patient28',
    'name': 'AINS (anti-inflammatoires non stéroïdiens)',
    'description':
        'Réaction allergique aux anti-inflammatoires non stéroïdiens.',
    'symptoms': ['Urticaire', 'Éruptions cutanées', 'Anaphylaxie'],
    'treatments': ['Éviter les AINS', 'Antihistaminiques', 'Épinéphrine'],
    'type': 'Médicamenteuse',
    'status': 'Active',
    'reactions': ['Légère', 'Modérée', 'Sévère']
  }
];
List<Map<String, dynamic>> exemplesHandicaps = [
  {
    'id': 'disability1',
    'patientId': 'patient1',
    'name': 'Cécité',
    'description': 'Perte totale ou partielle de la vision.',
    'type': 'Sensoriel',
    'status': 'Permanent',
    'level': 'Sévère',
  },
  {
    'id': 'disability2',
    'patientId': 'patient2',
    'name': 'Surdité',
    'description': 'Perte totale ou partielle de l\'audition.',
    'type': 'Sensoriel',
    'status': 'Permanent',
    'level': 'Modérée',
  },
  {
    'id': 'disability3',
    'patientId': 'patient3',
    'name': 'Paralysie',
    'description':
        'Perte de la capacité à bouger une ou plusieurs parties du corps.',
    'type': 'Physique',
    'status': 'Permanent',
    'level': 'Sévère',
  },
  {
    'id': 'disability4',
    'patientId': 'patient4',
    'name': 'Trouble du spectre de l\'autisme',
    'description':
        'Trouble neurodéveloppemental affectant la communication et le comportement.',
    'type': 'Cognitif',
    'status': 'Permanent',
    'level': 'Modérée',
  },
  {
    'id': 'disability5',
    'patientId': 'patient5',
    'name': 'Trisomie 21',
    'description':
        'Trouble génétique causé par la présence d\'une copie supplémentaire du chromosome 21.',
    'type': 'Cognitif',
    'status': 'Permanent',
    'level': 'Modérée',
  },
  {
    'id': 'disability6',
    'patientId': 'patient6',
    'name': 'Dystrophie musculaire',
    'description':
        'Groupe de maladies génétiques provoquant une faiblesse musculaire progressive.',
    'type': 'Physique',
    'status': 'Progressif',
    'level': 'Sévère',
  },
  {
    'id': 'disability7',
    'patientId': 'patient7',
    'name': 'Épilepsie',
    'description':
        'Trouble neurologique caractérisé par des crises récurrentes.',
    'type': 'Neurologique',
    'status': 'Permanent',
    'level': 'Modérée',
  },
  {
    'id': 'disability8',
    'patientId': 'patient8',
    'name': 'Sclérose en plaques',
    'description': 'Maladie auto-immune affectant le système nerveux central.',
    'type': 'Neurologique',
    'status': 'Progressif',
    'level': 'Sévère',
  },
  {
    'id': 'disability9',
    'patientId': 'patient9',
    'name': 'Lésion de la moelle épinière',
    'description':
        'Dommage à la moelle épinière résultant en une perte de fonction, comme la mobilité et/ou la sensation.',
    'type': 'Physique',
    'status': 'Permanent',
    'level': 'Sévère',
  },
  {
    'id': 'disability10',
    'patientId': 'patient10',
    'name': 'Trouble de stress post-traumatique (TSPT)',
    'description':
        'Trouble anxieux développé après avoir vécu ou été témoin d\'un événement traumatique.',
    'type': 'Psychologique',
    'status': 'Permanent',
    'level': 'Modérée',
  }
];
List<Map<String, dynamic>> exemplesHabitudes = [
  {
    'name': 'Tabagisme',
    'frequency': 'Quotidienne',
    'duration': 'Longue',
    'intensity': 'Élevée',
    'patientId': 'patient1',
  },
  {
    'name': 'Exercice physique',
    'frequency': 'Hebdomadaire',
    'duration': 'Moyenne',
    'intensity': 'Moyenne',
    'patientId': 'patient2',
  },
  {
    'name': 'Consommation d\'alcool',
    'frequency': 'Mensuelle',
    'duration': 'Longue',
    'intensity': 'Faible',
    'patientId': 'patient3',
  },
  {
    'name': 'Alimentation équilibrée',
    'frequency': 'Quotidienne',
    'duration': 'Longue',
    'intensity': 'Élevée',
    'patientId': 'patient4',
  },
  {
    'name': 'Sommeil régulier',
    'frequency': 'Quotidienne',
    'duration': 'Longue',
    'intensity': 'Moyenne',
    'patientId': 'patient5',
  },
  {
    'name': 'Consommation de caféine',
    'frequency': 'Quotidienne',
    'duration': 'Courte',
    'intensity': 'Élevée',
    'patientId': 'patient6',
  },
  {
    'name': 'Méditation',
    'frequency': 'Hebdomadaire',
    'duration': 'Moyenne',
    'intensity': 'Faible',
    'patientId': 'patient7',
  },
  {
    'name': 'Lecture',
    'frequency': 'Mensuelle',
    'duration': 'Moyenne',
    'intensity': 'Faible',
    'patientId': 'patient8',
  },
  {
    'name': 'Jardinage',
    'frequency': 'Hebdomadaire',
    'duration': 'Longue',
    'intensity': 'Moyenne',
    'patientId': 'patient9',
  },
  {
    'name': 'Voyages',
    'frequency': 'Annuelle',
    'duration': 'Longue',
    'intensity': 'Élevée',
    'patientId': 'patient10',
  }
];
