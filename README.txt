Hiérarchie:

NOTE: seul les documents utiles sont mentionnés


Matlab
	ACT_Fe_attraction.mat
	   -> matrice pour calculer Fe
	ACT_Fs.mat
	   -> matrice pour calculer Fs
	Actionneur_LIN.m
	   -> Script de linéarisation des actionneurs et présentation des résultats
	CONSTANTES.m
	   -> Script de calcul de toutes les constantes pour les simulations
	equilibre.m
	   -> Script de calcul de l'équilibre et de découplage
	fonctionDeTransfert.m
	   -> Script de calcul des fonctions de transfert à partir des equations découplées
	IDENTIFICATION_MC.m
	   -> Script de calcul de la fonction représentant les actionneurs par moindre carrés
	Linearisation.m
	   -> Linéarisation symbolique à partir des équations non-linéaires
	rsquare.m
	   -> fonction trouvée sur internet pour calculer les r^2 et rms sans erreur d'approximation; confirme les valeurs obtenues à la main

Simulation
	SIMULINK_LIN
		COMPLET
			run_bancessai_LIN.m
			   -> Script pour simuler le système linéaire non-découplé
			graph_LIN.m
			   -> Script de sortie de tous les graphiques de la simulation
			simulation_LIN.slx
			   -> Simulink linéaire non-découplée
	SIMULINK_LIN_DEC
		COMPLET
			run_bancessai_LIN_DEC.m
			   -> Script pour simuler le système linéaire découplé
			graph_LIN_DEC.m
			   -> Script de sortie de tous les graphiques de la simulation
			simulation_LIN_DEC.slx
			   -> Simulink linéaire	découplée
	SIMULINK_NL
		MODIFIE
			run_bancessai_NL.m
			   -> Script pour simuler le système non-linéaire
			graph_NL_modif.m
			   -> Script de sortie de tous les graphiques de la simulation
			simulation_NL_modif.slx
			   -> Simulink non-linéaire
		ORIGINAL
			-> exactement ce qui est fourni sur le site de la session

		Tests	(peu utile ; très brouillon) 
			MODIF_TEST
				run_bancessai.m
				   -> Script pour simuler le système non-linéaire en test
				DYNctl_ver4_etud_obfusc.slx
				   -> Simulink non-linéaire test
				GRAPHS.m
				   -> Script de sortie de tous les graphiques de la simulation
ARBORESCENCE_CODE.png
   -> Diagrame draw.io exporté en png qui présente la hiérarchie présente du code