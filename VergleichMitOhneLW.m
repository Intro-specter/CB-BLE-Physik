clear all

G = 9.81;

DELTA_T = input("Gebe Zeitintervall in s ein: ");
ANFANGSHOEHE = input("Gebe Anfangshoehe in m ein: ");
CW = input("Gebe Luftwiderstandsbeiwert (cw-Wert) ein: ");
RHO_L = input("Gebe Luftdichte in kg/m^3 ein: ");
A = input("Gebe Querschnittsflaeche in m^2 ein: ");
M = input("Gebe Masse in kg ein: ");

t(1) = 0;
v(1) = 0;
s(1) = 0;
a(1) = G;

i = 1;
while s(i) <= ANFANGSHOEHE
  t(i+1) = t(i) + DELTA_T;
  v(i+1) = v(i) + (G - (1/2*CW*RHO_L*A*(v(i))^2)/M) * DELTA_T;
  s(i+1) = s(i) + v(i) * DELTA_T;
  a(i+1) = G - (1/2*CW*RHO_L*A*(v(i+1))^2)/M;
  i = i + 1;
end

t_o(1) = 0;
v_o(1) = 0;
s_o(1) = 0;
a_o(1) = G;

i_o = 1
while s_o(i_o) <= ANFANGSHOEHE
  t_o(i_o+1) = t_o(i_o) + DELTA_T;
  s_o(i_o+1) = s_o(i_o) + v_o(i_o)*DELTA_T;
  v_o(i_o+1) = t_o(i_o+1)*G;
  i_o = i_o + 1;
end

fprintf("Endgeschwindigkeit Theorie (ohne LW): %6.2f m/s, %6.2f km/h\n", sqrt(2*G*ANFANGSHOEHE), sqrt(2*G*ANFANGSHOEHE)*3.6);
fprintf("Endgeschwindigkeit Theorie (mit LW): %6.2f m/s, %6.2f km/h\n", sqrt(2*G*M/(RHO_L*A*CW)), sqrt(2*G*M/(RHO_L*A*CW))*3.6);
fprintf("Endgeschwindigkeit Simulation (ohne LW): %6.2f m/s, %6.2f km/h\n", v_o(i_o), (v_o(i_o)*3.6));
fprintf("Endgeschwindigkeit Simulation (mit LW): %6.2f m/s, %6.2f km/h\n", v(i), (v(i)*3.6));
fprintf("Fallzeit (ohne LW): %6.2f s\n", t_o(i_o));
fprintf("Fallzeit (mit LW): %6.2f s\n", t(i));
fprintf("Anzahl Schritte zur Abbruchbedingung (ohne LW): %1.f\n", i_o);
fprintf("Anzahl Schritte zur Abbruchbedingung (mit LW): %1.f\n", i);

subplot(1,2,1);
plot(t,s,"b",t_o,s_o,"r");
grid on
title("s-t-Diagramm", "FontWeight","bold");
xlabel("Zeit in s");
ylabel("Strecke in m");

subplot(1,2,2);
plot(t,v,"b",t_o,v_o,"r");
grid on
title("v-t-Diagramm", "FontWeight","bold");
xlabel("Zeit in s");
ylabel("Geschwindigkeit in m/s");
legend("Mit Luftwiderstand","Ohne Luftwiderstand","location","northoutside");
