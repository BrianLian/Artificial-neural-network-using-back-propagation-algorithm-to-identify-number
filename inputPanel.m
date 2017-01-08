function inputPanel(action)
    global write;
    matDim = 16;

    if nargin == 0
        action = 'start';
    end

    switch(action)
    case 'start',
        clf;
        figure(1);
        axis([0 matDim 0 matDim]);  % �]�w�϶b�d��
        box on;                     % �N�϶b�[�W�Ϯ�
        set(gcf, 'WindowButtonDownFcn', 'inputPanel down');      % �]�w�ƹ����s�Q���U�ɪ��������O���utmouse down�v
    case 'down',
        set(gcf, 'WindowButtonMotionFcn', 'inputPanel move');    % �]�w�ƹ����ʮɪ��������O���utmouse move�v
        set(gcf, 'WindowButtonUpFcn', 'inputPanel up');          % �]�w�ƹ����s�Q����ɪ��������O���utmouse up�v
    case 'move',
        currPt = get(gca, 'CurrentPoint');
        x = fix(currPt(1,1));
        y = fix(currPt(1,2));
        write(x+1, y+1) = 1;
        plot(x, y, 'o', 'MarkerSize', 15, 'LineWidth', 15, 'EraseMode', 'normal');
        axis([0 matDim 0 matDim]);
        hold on;
    case 'up',
        set(gcf, 'WindowButtonMotionFcn', '');  % �M���ƹ����ʮɪ��������O
        set(gcf, 'WindowButtonUpFcn', '');      % �M���ƹ����s�Q����ɪ��������O
    end