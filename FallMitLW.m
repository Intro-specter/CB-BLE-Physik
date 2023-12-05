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

fprintf("Endgeschwindigkeit Theorie: %6.2f m/s, %6.2f km/h\n", sqrt(2*G*M/(RHO_L*A*CW)), sqrt(2*G*M/(RHO_L*A*CW))*3.6);
fprintf("Endgeschwindigkeit Simulation: %6.2f m/s, %6.2f km/h\n", v(i), (v(i)*3.6));
fprintf("Fallzeit: %6.2f s\n", t(i));
fprintf("Anzahl Schritte zur Abbruchbedingung: %1.f\n", i);

subplot(1,2,1);
plot(t,s);
grid on
title("s-t-Diagramm", "FontWeight","bold");
xlabel("Zeit in s")
ylabel("Strecke in m")

subplot(1,2,2);
plot(t,v);
grid on
title("v-t-Diagramm", "FontWeight","bold");
xlabel("Zeit in s")
ylabel("Geschwindigkeit in m/s")
