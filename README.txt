Hiérarchie:

NOTE: seul les documents utiles sont mentionnés




Matlab
	Data
		Emplacement des fichiers.mat de sortie de toutes les fonctions

	Functions
		AvancePhaseBode1.m
		   -> Génère un compesateur AvPh selon la méthode de bode (ref. Bode 1 de JdeL)
		ComputeTrajectories.m
		   -> Fonciton qui prends les paramètres voulus de la trajectoire selon l'annexe E
		ErrRP.m
		   -> calcule l'erreur en régime permanent d'une FT
		Fp.m
		   -> calcule la dérivée début fin d'un échantillon discret
		GetClass.m
		   -> retourne la classe d'une FT
		InterpolationLagrange.m		
		   -> Retourn ele polynome d'interpolation avec la méthode de lagrange
		MoindreCarreLineaire.m
		   -> Réalise un moindre carré et les erreurs
		PIBode.m
		   -> Génère un compesateur PI selon la méthode de bode (ref. Bode 1 de JdeL)
		RetardPhaseBode1.m
		   ->Génère un compesateur RePh selon la méthode de bode (ref. Bode 1 de JdeL)
		Trapeze.m
		   ->Calcule un intégrale par trapèze et l'erreur	
		testdiscret.p	
		   -> Fichier fourni de calcul de compensateur


	Actionneur_LIN.m
	   -> Script de linéarisation des actionneurs et présentation des résultats
	asservissement_phi.m
	   -> Calcul du compensateur en phi (ancienne version
	asservissement_phi_theta2.m
	   -> Calcul du compensateur en phi 2e version
	asservissement_x_y.m
	   -> Calcul du compensateur en x et y
	asservissement_z.m
	   -> Calcul du compensateur en z
	CONSTANTES.m
	   -> Script de calcul de toutes les constantes pour les simulations
	equilibre.m
	   -> Script de calcul de l'équilibre et de découplage
	IDENTIFICATION_MC.m
	   -> Script de calcul de la fonction représentant les actionneurs par moindre carrés
	Linearisation.m
	   -> Linéarisation symbolique à partir des équations non-linéaires
	rsquare.m
	   -> fonction trouvée sur internet pour calculer les r^2 et rms sans erreur d'approximation; confirme les valeurs obtenues à la main
	testdiscret.p	
	   -> Fichier fourni de calcul de compensateur
	Trajectoire.m
	   -> Script de test des trajectoires
	SC5.m
	   -> Moindre carré pour les capteurs


Simulation
	***NOTE: Tous ces fichiers contiennent l'asservissement créé

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
			comparaisonasservissement.m
			   -> Script de comparaison des asservissements
			tamp.mat
			   -> Matrice des résultats de comparaison des asservissements		
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
plate_control_profile.xml
   -> Configuration des actionneurs pour le banc d'essais
fonctionDisctetise.txt
   -> Compensateurs discétisés sous forme texte pour présentation

