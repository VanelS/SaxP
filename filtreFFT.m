function [] = filtreFFT(chemin, RD,RG,gyr, attribut, indTemps ) 
    
    %extraction des donn�es des fichier 
    un=importdata([chemin '\' RD],';');
    deux=importdata([chemin '\' RG],';');
    trois=importdata([chemin '\' gyr],';');
    
    A=un.data(:,indTemps);
    B=un.data(:,attribut);
    D=deux.data(:,attribut);
    F=trois.data(:,attribut);
    
    
    
    
% %       
% % %         pris sur le forum : http://forums.futura-sciences.com/logiciel-software-open-source/688765-traitement-de-signal-maltab.html
% %         Ts=A(2)-A(1); % sampling time, extracted from the csv-file
% %        
% %         f0=50; % frequency of the fundamental
% %         nharm=50; % number of harmonics we want to plot
% %         plotMyFFT( B, Ts, f0, nharm);
% %         
% %         
        fe=1/(A(2)-A(1));
        
        S=size(A);
        L=S(2);

        NFFT = 2^nextpow2(L); % Next power of 2 from length of y
        Y = fft(B,NFFT)/L;
        figure
        f = fe/2*linspace(0,1,NFFT/2+1);
%         Plot single-sided amplitude spectrum.
        s=2*abs(Y(1:NFFT/2+1));
        plot(f(1:length(f)),s(1:length(s))) 
        title('Single-Sided Amplitude Spectrum of y(t)')
        xlabel('Frequency (Hz)')
        ylabel('|Y(f)|')
        for i=1:length(s)
            if(s(1,i)>=2.1)
                break
            end
        end
        Ds = conv(s(i:length(s)),ones(1,15)/15);
        Ds=[s(1:i-1),Ds];
        figure
        plot(f,Ds) 
        title('Single-Sided Amplitude Spectrum of y(t)')
        xlabel('Frequency (Hz)')
        ylabel('|Y(f)|')
        
        %le filtre moyenneur "filter" doivent avoir ses deux permier
        %param�tre de m�me taille car nous observons un effet de distortion
        %de la courbe resultant du filtre par rapport � la courbe d'origine
        %(si le premier est plus petit que le second alors la courbe
        %diminue en amplitude sinon dans le cas inverse la courbe
        %augmentera en amplitude par rapport � la courbe d'orignie).
        %max < 110  min > 40
        
%         i=60;
% %         while i<200 
%             fig=figure
%             hold on
%             plot(A,B)
% %             vFiltre=filter(ones(i,1),i,B); 
% %             xfiltfilt = filtfilt(ones(i,1),i,B(1:length(A)));
% %             plot(A,xfiltfilt,'r')
%             
%             
%             
% % %         filtre gaussien
% % 
% %         % Construct blurring window.
% %       
% %         gaussFilter = gausswin(10);
% %         gaussFilter = gaussFilter / sum(gaussFilter); % Normalize.
% % % 
% % %         % Do the blur.
% %         smoothedVector = conv(B, gaussFilter);
% %         plot(A(1:20:length(A)),smoothedVector(1:20:length(A)),'k')
% %             for i=1:length(B)
% %                 if isnan(B(i))
% %                     i
% %                     B(i)
% %                 end
% %             end
%            
%            %coupeCycle(A,xfiltfilt, chemin, fichier, indTemps,-abs(mean(B))-1);
% %             saveas(fig,['filter-' num2str(i) '.fig'],'fig');
% %             
% %             i=i+10;
% 
%            cycles=gyro();
%            for i=1:length(cycles)
%                plot(A(cycles(i,1):cycles(i,2)),B(cycles(i,1):cycles(i,2)),'g')
%            end
% 
% 
% 
%             hold off
% %         end
%        
%     
end