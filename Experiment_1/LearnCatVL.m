function LearnCatVL
% First stage is category learning with feedback. 
% Stimuli arbitrarily assigned to two categories.
% Response buttons: z and m

% remove:
Screen('Preference', 'SkipSyncTests', 1);

% get input
answers = inputdlg({'SubID (#)', 'Gender (m/f/o)', 'Age'}, 'Inputs', 3, {'0','',''});

sub = str2num(answers{1});

% key assignment
KbName('UnifyKeyNames');
startKey = KbName('space');
quitKeys = [KbName('q') KbName('p')]; % hold both to quit
key1 = KbName('z');
key2 = KbName('m');

HideCursor; commandwindow;

datafile = ['data/data-' num2str(sub) '.mat'];

% trial timing (s)
imDur = 1; 
imITI = 1;
errDelay = .5;

randseed = rng('shuffle');

imfiles = dir('TaskImages/*.jpg');
imfiles = Shuffle(imfiles);

% open/set up screen
[w,wrect] = Screen('OpenWindow', max(Screen('Screens')),[128 128 128]); % ,[0 0 500 500]);
imRect = CenterRect([0 0 256 256], wrect);
ifi = Screen('GetFlipInterval', w);
fixRect = CenterRect([0 0 20 20],wrect); 
fixColor = [255 255 0];
fixCorrectColor = [0 255 0];
fixErrorColor = [255 0 0];

% 16 pairs equal numbers of...
% A -> A
% B -> B
% A -> B
% B -> A

% no singletons in this experiment, too confusing to modify with
% singletons in place
itemsPaired = 32; % 1/2 of this number is the number of pairs
nPairs = itemsPaired/2; 
itemsUnpaired = 0;

nRepsPerBlock = 4;
trialsPerBlock = nRepsPerBlock*(itemsPaired+itemsUnpaired);

nBlocks = 6; 

for idx = 1:itemsPaired
    imagetex(idx) = Screen('MakeTexture', w, imread(['TaskImages/' imfiles(idx).name]));
end
Screen('PreloadTextures',w,imagetex(:));

pairList = []; % details about pairs
foilList = []; % details about foils
% first col indicates category of item 1 (0 or 1)
% second col indicates image index of item 1 
% third number is category of item 2 (0 or 1)
% fourth col is image index of item 1
% fifth col, for convenience, is whether this is a pair with
% matched-category (1) or mixed-category (2) items
for idx = 1:(nPairs/4)
    pairList(idx,:) = [1 (idx-1)*2+1 1 (idx-1)*2+2 1];
end
for idx = (nPairs/4+1):2*(nPairs/4)
    pairList(idx,:) = [2 (idx-1)*2+1 2 (idx-1)*2+2 1];
end
for idx = (2*nPairs/4+1):3*(nPairs/4)
    pairList(idx,:) = [1 (idx-1)*2+1 2 (idx-1)*2+2 0];
end
for idx = (3*nPairs/4+1):4*(nPairs/4)
    pairList(idx,:) = [2 (idx-1)*2+1 1 (idx-1)*2+2 0];
end

% WARNING this part is hard-coded expecting only 4 pairs per possible combo! Unlike
% above...need to modify if increase/decrease number of pairs.
foilList = pairList;
foilList(1:3,4) = pairList(2:4,4);
foilList(4,4) = pairList(1,4);
foilList(5:7,4) = pairList(6:8,4);
foilList(8,4) = pairList(5,4);
foilList(9:11,4) = pairList(10:12,4);
foilList(12,4) = pairList(9,4);
foilList(13:15,4) = pairList(14:16,4);
foilList(16,4) = pairList(13,4);

data = zeros(nBlocks*trialsPerBlock, 9);

IMPAIR1 = 1; IMPAIR2 = 2; 



for block = 1:nBlocks
    
    
    
    % shuffle trial order for this block, guarantee no pair
    % repetition
    while 1
        pairedOrder = Shuffle(repmat(1:size(pairList,1),1, nRepsPerBlock));
        imageOrder = zeros(trialsPerBlock, 3);
        imOrderIdx = 1;
        for idx = 1:length(pairedOrder)
            imageOrder(imOrderIdx, :) = [pairList(pairedOrder(idx),1:2) IMPAIR1]; 
            imOrderIdx = imOrderIdx + 1;
            imageOrder(imOrderIdx, :) = [pairList(pairedOrder(idx),3:4) IMPAIR2];
            imOrderIdx = imOrderIdx + 1;
        end
        % logic of this is confusing, but this next statement is a test for 
        % immediately repeated image, 2-back repeat, or immediately repeated pair
        if ~any((imageOrder(1:(end-1),2)==imageOrder(2:end,2)) & (imageOrder(1:(end-1),1)==imageOrder(2:end,1)) ) && ~any((imageOrder(1:(end-2),2)==imageOrder(3:end,2)) & (imageOrder(1:(end-2),1)==imageOrder(3:end,1)))
            break; 
        end
    end
    
    if block == 1
        DrawFormattedText(w,'In this experiment, you will see 32 images. \nTry to learn which images are category Z and which are category M.\nYou have to learn by trial and error. When you see an image, make a guess within one second.\nYou will get correct/incorrect feedback, and correct trials will proceed faster.\nOn correct trials the fixation marker will turn green.\nOn incorrect responses, the fixation marker will turn red and there will be a delay.\nYour response keys are z and m on the keyboard. \nSpace to start.','center','center',[0 0 0]);
    else
        DrawFormattedText(w,['Block break, rest briefly if needed.\nLast block, you got ' num2str(round(100*blockAc/trialsPerBlock)) '% correct. Try to get 100%!\nUse Z and M keys to categorize.\nTry to be as accurate as possible!\nPress space to start.'],'center','center',[0 0 0]);
    end
    Screen('Flip',w);

    blockAc = 0;
    
    [keyDown, secs, keyCodes] = KbCheck(-1);
    while ~keyCodes(startKey)
        [keyDown, secs, keyCodes] = KbCheck(-1);
        if all(keyCodes(quitKeys))
            sca; return;
        end
    end

    while keyCodes(startKey)
        [keyDown, secs, keyCodes] = KbCheck(-1);
    end
    Screen('FrameOval', w, fixColor, fixRect); 
    nextOnset = Screen('Flip', w) + imITI;
    
    for trial = 1:trialsPerBlock
        imType = imageOrder(trial, 1);
        imIdx = imageOrder(trial, 2); 
        trialType = imageOrder(trial, 3);
        
        corResp = imType;
        
        Screen('DrawTexture', w, imagetex(imIdx),[],imRect);
        Screen('FrameOval', w, fixColor, fixRect); 
        imFlip = Screen('Flip', w, nextOnset - ifi/2);
        
        % check for response
        resp = -1; rt = -1; acc = 0;
        while (GetSecs - imFlip) < (imDur - ifi)
            [keyDown, secs, keyCodes] = KbCheck(-1);
            if keyDown 
                if keyCodes(key1) 
                    resp = 1;
                    rt = secs - imFlip;
                    acc = (corResp == resp);
                    break;
                elseif keyCodes(key2) 
                    resp = 2;
                    rt = secs - imFlip;
                    acc = (corResp == resp);
                    break;
                elseif all(keyCodes(quitKeys))
                    save(datafile); Screen('Close', imagetex(:)); sca; return;
                end
            end
        end
        
        blockAc = blockAc + acc;
        
        if resp ~= -1
            Screen('DrawTexture', w, imagetex(imIdx),[],imRect);
            if acc
                Screen('FillOval', w, fixCorrectColor, fixRect);
            else
                Screen('FillOval', w, fixErrorColor, fixRect); 
            end
            Screen('Flip', w);
        end
        
        % start blank interval, continue to monitor for resp if none
        % received
        nextOnset = imFlip + imDur;
        if resp == -1
            Screen('FrameOval', w, fixColor, fixRect); 
        else
            if acc
                Screen('FillOval', w, fixCorrectColor, fixRect);
            else
                Screen('FillOval', w, fixErrorColor, fixRect); 
            end
        end
        imDown = Screen('Flip', w, nextOnset - ifi/2);
        while ((GetSecs - imDown) < (imITI - ifi)) && (resp == -1)
            [keyDown, secs, keyCodes] = KbCheck(-1);
            if keyDown 
                if keyCodes(key1) 
                    resp = 1;
                    rt = secs - imFlip;
                    acc = (corResp == resp);
                    break;
                elseif keyCodes(key2) 
                    resp = 2;
                    rt = secs - imFlip;
                    acc = (corResp == resp);
                    break;
                elseif all(keyCodes(quitKeys))
                    save(datafile); sca; Screen('Close', imagetex(:)); return;
                end
            end
        end
        
        if resp ~= -1
            if acc
                Screen('FillOval', w, fixCorrectColor, fixRect);
            else
                Screen('FillOval', w, fixErrorColor, fixRect); 
            end
            Screen('Flip',w);
        end
        
        if acc
            nextOnset = imDown + imITI; 
        else 
            nextOnset = imDown + imITI + errDelay;
        end
       
        % log data
        data((block-1)*trialsPerBlock+trial, :) = [sub block trial trialType imType imIdx corResp acc rt];
    end      
end
save(datafile);


% now do stage 2 -- here, show a target and foil pair, then force choice
% which is more familiar
% we have 16 target pairs and 16 foil pairs. 
% each will appear in 4 recognition trials, once as first pair and once as
% second pair
% 16x4 = 64 trials total. This stage will likely take about 10 minutes,
% perhaps longer.
%vsl_awareness;
save(datafile);
%  instructions
recInst = ['You are now entering the last stage of the experiment.\n' ...
           'You may or may not have noticed, but some images ALWAYS\npredicted other images in the sequence you just experienced.\n' ...
           'That is, 16 particular fractal images were ALWAYS\nfollowed by the same fractal image.\n' ...
           'In this last stage, we are going to show you two pairs\non each trial, Sequence 1 and Sequence 2, in succession.\n' ...
           'Your task is to pick which was the sequence that appeared\nduring the task. There is always a correct answer.\n' ...
           'Half the pairs are new, but will repeat during this stage.\nAlways pick the sequence that appeared during the main task you just finished.\n' ...
           'You must make a response on every trial. If you are unsure\non any or all trials, that is OK, but please GO WITH YOUR GUT when you are not sure.\n' ...
           'If you do not understand, please go speak with the experimenter now.' ...
           '\n\nTo proceed, please press the Y key to indicate \nthat you understand these instructions. '];

       
DrawFormattedText(w, recInst, 100, 'center', [0 0 0]);
recInstUpTime = Screen('Flip',w);

% determine combos / trial order
recogReps = 4; 
numRecTrials = 16*recogReps;
% lazily match target pairs with unique foil pairs, and guarantee no
% immediate trial repetitions of foil or target
% takes only a few seconds on my macbook, should finish while they view
% instructions
while 1
    % guarantee no immediately repeated target pair presentations
    while 1
        targetOrder = Shuffle(repmat(1:length(pairList), 1, recogReps));
        if ~any(targetOrder(1:(end-1))==targetOrder(2:end))
            break;
        end
    end
    % guarantee no immediately repeated foil pair presentations
    while 1
        foilOrder = Shuffle(repmat(1:length(foilList), 1, recogReps));
        if ~any(foilOrder(1:(end-1))==foilOrder(2:end))
            break;
        end
    end
    % guarantee no repeated combinations of target/foil pairs
    % make a unique number based on target / foil combos
    comboTypes = (targetOrder-1).*16+foilOrder;
    if length(unique(comboTypes))==length(comboTypes)
        break;
    end
end
    

while GetSecs - recInstUpTime < 5 
end

while 1
    [keyDown, secs, keyCodes] = KbCheck(-1);
    if keyDown
        if keyCodes(KbName('y'))
            break;
        end
    end
end

orderOrder = Shuffle(repmat(1:2, 1, numRecTrials/2));

recData = zeros(numRecTrials, 12); % CHECK THIS, correct # columns?

seqLabelDur = 0.5; % used for both the duration of the 'Sequence N' label and the blank period that follows

for recTrial = 1:2%numRecTrials
    thisOrder = orderOrder(recTrial);
    
    targ1ImType = pairList(targetOrder(recTrial),1); % indexes the target image class
    targ1ImIdx = pairList(targetOrder(recTrial),2);  % indexes specific image within that class
    targ2ImType = pairList(targetOrder(recTrial),3); 
    targ2ImIdx = pairList(targetOrder(recTrial),4); 
    
    foil1ImType = foilList(foilOrder(recTrial),1);
    foil1ImIdx = foilList(foilOrder(recTrial),2); 
    foil2ImType = foilList(foilOrder(recTrial),3);
    foil2ImIdx = foilList(foilOrder(recTrial),4); 
    
    DrawFormattedText(w, 'Get ready! Press space bar to start the next trial.', 'center', 'center', [0 0 0]);
    Screen('Flip', w); 
    
    while 1
        [keyDown, secs, keyCodes] = KbCheck(-1);
        if keyDown 
            if keyCodes(KbName('space'))
                break;
                elseif all(keyCodes(quitKeys))
                    save(datafile); Screen('Close', imagetex(:)); sca; return;
                
            end
        end
    end
    
    % show "Sequence 1"
    DrawFormattedText(w, 'Sequence 1', 'center', 'center', [0 0 0]);
    flipTime = Screen('Flip', w); 
    
    Screen('FrameOval', w, fixColor, fixRect);
    flipTime = Screen('Flip', w, flipTime + seqLabelDur - ifi/2); 
    
    Screen('FrameOval', w, fixColor, fixRect);
    if thisOrder == 1 % target comes first
        Screen('DrawTexture', w, imagetex(targ1ImIdx),[],imRect);
    else
        Screen('DrawTexture', w, imagetex(foil1ImIdx),[],imRect);
    end
    flipTime = Screen('Flip', w, flipTime + seqLabelDur - ifi/2); 
    
    Screen('FrameOval', w, fixColor, fixRect);
    flipTime = Screen('Flip', w, flipTime + imDur - ifi/2);
    
    Screen('FrameOval', w, fixColor, fixRect);
    if thisOrder == 1
        Screen('DrawTexture', w, imagetex(targ2ImIdx),[],imRect);
    else
        Screen('DrawTexture', w, imagetex(foil2ImIdx),[],imRect);
    end
    flipTime = Screen('Flip', w, flipTime + imITI - ifi/2);
    
    Screen('FrameOval', w, fixColor, fixRect);
    flipTime = Screen('Flip', w, flipTime + imDur - ifi/2);
    
    % show "Sequence 2"
    DrawFormattedText(w, 'Sequence 2', 'center', 'center', [0 0 0]);
    flipTime = Screen('Flip', w, flipTime + imITI - ifi/2); 
    
    Screen('FrameOval', w, fixColor, fixRect);
    flipTime = Screen('Flip', w, flipTime + seqLabelDur - ifi/2); 
    
    Screen('FrameOval', w, fixColor, fixRect);
    if thisOrder == 2 
        Screen('DrawTexture', w, imagetex(targ1ImIdx),[],imRect);
    else
        Screen('DrawTexture', w, imagetex(foil1ImIdx),[],imRect);
    end
    flipTime = Screen('Flip', w, flipTime + seqLabelDur - ifi/2); 
    
    Screen('FrameOval', w, fixColor, fixRect);
    flipTime = Screen('Flip', w, flipTime + imDur - ifi/2);
    
    Screen('FrameOval', w, fixColor, fixRect);
    if thisOrder == 2
        Screen('DrawTexture', w, imagetex(targ2ImIdx),[],imRect);
    else
        Screen('DrawTexture', w, imagetex(foil2ImIdx),[],imRect);
    end
    flipTime = Screen('Flip', w, flipTime + imITI - ifi/2);

    DrawFormattedText(w, 'Which was more familiar from the first stage of the experiment? \nPress 1 for the first sequence, 2 for the other sequence. \nIf unsure, go with your gut feeling.', 'center', 'center', [0 0 0]);
    flipTime = Screen('Flip', w, flipTime + imITI - ifi/2); 
    
    while 1
        [keyDown, secs, keyCodes] = KbCheck(-1); 
        if keyDown
            if keyCodes(KbName('1!')) || keyCodes(KbName('1'))
                resp = 1; break;
            elseif keyCodes(KbName('2@')) || keyCodes(KbName('2'))
                resp = 2; break; 
                elseif all(keyCodes(quitKeys))
                    save(datafile); Screen('Close', imagetex(:)); sca; return;
                
            end
        end
    end
    acc = (resp == thisOrder);
    rt = secs - flipTime;
    
    Screen('FrameOval', w, fixColor, fixRect);
    flipTime = Screen('Flip', w, flipTime + imITI - ifi/2);
    
    % record data
    recData(recTrial,:) = [targ1ImType targ1ImIdx targ2ImType targ2ImIdx foil1ImType foil1ImIdx foil2ImType foil2ImIdx thisOrder resp acc rt];
end

save(datafile);

Screen('Close', imagetex(:));
sca; 
end

