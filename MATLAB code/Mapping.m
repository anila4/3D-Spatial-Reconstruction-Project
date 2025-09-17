%Deev Patel
%pated201
%400501776

clear;

s = serialport("COM11", 115200, "Timeout", 50);
flush(s);
fprintf("Opening COM11\n");

input("Press Enter to begin...", 's');
write(s, 's', 'char');


while true
    line = readline(s);
    if contains(string(line), "Start")
        disp("Start detected.");
        break;
    end
end

% Parameters
depth = 1;                    % number of Z-layers
points_per_layer = 128;        % points per circular sweep
angle_step_deg = 360 / points_per_layer;
z_step = 30;                   % height per layer in cm
theta = linspace(0, 2*pi - 2*pi/points_per_layer, points_per_layer);

% Storage
results = zeros(0, 3);  % columns: [r, angle (deg), z]

% Loop over layers
for layer = 0:(depth - 1)
    current_z = layer * z_step;
    fprintf("Collecting layer at Z = %d cm...\n", current_z);
    input("Press Enter for next layer...", 's');

    for i = 1:points_per_layer
        while true
            line = strtrim(string(readline(s)));
            match = regexp(line, '\[(\-?\d+)\]', 'tokens');
            if ~isempty(match)
                r = str2double(match{1});
                angle_deg = (i - 1) * angle_step_deg;

                % Store
                results(end+1, :) = [r, angle_deg, current_z];

                x = r * cosd(angle_deg);
                y = r * sind(angle_deg);
                z = current_z;

                fprintf("Z = %3d | r = %4d → x = %7.2f, y = %7.2f, z = %3d\n", z, r, x, y, z);
                break;
            end
        end
    end
end

% Convert to Cartesian
measurement_data = results.';
[x, y, z] = pol2cart(deg2rad(measurement_data(2,:)), measurement_data(1,:), measurement_data(3,:));

% Flip x and z components to match plotting style
cartesian_data = [z; y; x];

% Plot
figure;
scatter3(cartesian_data(1,:), cartesian_data(2,:), cartesian_data(3,:));
hold on;

% Connect points in each layer
for d = 1:depth
    offset = (d - 1) * points_per_layer;
    for i = 1:points_per_layer-1
        plot3(cartesian_data(1, offset+i:offset+i+1), ...
              cartesian_data(2, offset+i:offset+i+1), ...
              cartesian_data(3, offset+i:offset+i+1), 'k-');
    end
    % Close the loop
    plot3([cartesian_data(1, offset+1), cartesian_data(1, offset+points_per_layer)], ...
          [cartesian_data(2, offset+1), cartesian_data(2, offset+points_per_layer)], ...
          [cartesian_data(3, offset+1), cartesian_data(3, offset+points_per_layer)], 'k-');
end

% Connect vertical lines across layers
for d = 1:depth-1
    for i = 1:points_per_layer
        p1 = (d - 1) * points_per_layer + i;
        p2 = d * points_per_layer + i;
        plot3([cartesian_data(1, p1), cartesian_data(1, p2)], ...
              [cartesian_data(2, p1), cartesian_data(2, p2)], ...
              [cartesian_data(3, p1), cartesian_data(3, p2)], 'k-');
    end
end

% Finalize
hold off;
title('3D Scan (Manual Layer Advance)');
xlabel('X Depth');
ylabel('Y Width');
zlabel('Z Height');
grid on;

% Close port
clear s;
fprintf("Done and port closed.\n");
