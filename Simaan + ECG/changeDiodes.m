function [A, B] = changeDiodes(Pao, Pae, Pve, E)

if(Pae > Pve)
    Da = 0;
    Dm = 1;
elseif Pve > Pao
    Da = 1;
    Dm = 0;
else
    Da = 0;
    Dm = 0;
end

% Resistances
Rs = 1; % Sistemic Vascular
Rm = 0.0050; % Mitral Valve
Ra = 0.0010; % Aortic Valve
Rc = 0.0398; % Characteristic

% Compliances
Cr = 4.400; % Left atrial
Cs = 1.330; % Systemic
Ca = 0.080; % Aortic
Cae = Cr;
Cao = Ca;

% Inertance
Ls = 0.0005; % Inertance of blood in Aorta
L = Ls;
V0 = 10; % Volume do ventrículo em ml

A = [ -((Dm/Rm) + (Da/Ra))*E      Da/Ra           0           0           Dm/Rm;
      Da/(Ra*Cao)*E               -(Da/(Ra*Cao))  (-1/Cao)    0           0;
      0                           1/L             -Rc/L       -1/L        0;
      0                           0               1/Cs        -1/(Rs*Cs)  1/(Rs*Cs);
      Dm/(Rm*Cae)*E               0               0           1/(Rs*Cae)  (-1/Cae)*((1/Rs) + (Dm/Rm))];

B = [   ((Dm/Rm) + (Da/Ra))*V0;
        (-Da*V0)/(Ra*Cao);
        0;
        0;
        -(Dm*V0)/(Rm*Cae)];
end

