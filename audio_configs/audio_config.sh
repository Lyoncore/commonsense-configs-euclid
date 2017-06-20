#! /bin/bash
amixer -ccherrytrailcrau cset name='media0_out mix 0 media1_in Switch' 1
amixer -ccherrytrailcrau cset name='codec_out0 mix 0 pcm0_in Switch' 1
amixer -ccherrytrailcrau cset name='pcm0_in Gain 0 Volume' 0 0
amixer -ccherrytrailcrau cset name='media1_in Gain 0 Volume' 0 0
amixer -ccherrytrailcrau cset name='codec_out0 Gain 0 Volume' 0 0
amixer -ccherrytrailcrau cset name='media1_in Gain 0 Switch' 0
amixer -ccherrytrailcrau cset name='pcm0_in Gain 0 Switch' 0
amixer -ccherrytrailcrau cset name='codec_out0 Gain 0 Switch' 0
amixer -ccherrytrailcrau cset name='DAC1 L Mux' 'IF1 DAC'
amixer -ccherrytrailcrau cset name='DAC1 R Mux' 'IF1 DAC'
amixer -ccherrytrailcrau cset name='DAC1 MIXL DAC1 Switch' 1
amixer -ccherrytrailcrau cset name='DAC1 MIXR DAC1 Switch' 1
amixer -ccherrytrailcrau cset name='Stereo DAC MIXL DAC L1 Switch' 1
amixer -ccherrytrailcrau cset name='Stereo DAC MIXR DAC R1 Switch' 1
amixer -ccherrytrailcrau cset name='Stereo DAC MIXR DAC L1 Switch' 1
amixer -ccherrytrailcrau cset name='PDM1 L Mux' 'Stereo DAC'
amixer -ccherrytrailcrau cset name='PDM1 R Mux' 'Stereo DAC'
#amixer -ccherrytrailcrau cset name='HPOVOL MIXL DAC1 Switch' 1
#amixer -ccherrytrailcrau cset name='HPOVOL MIXR DAC1 Switch' 1
#amixer -ccherrytrailcrau cset name='HPO MIX HPVOL Switch' 1
#amixer -ccherrytrailcrau cset name='Headphone Switch' 1
sleep 1
amixer -ccherrytrailcrau cset name='pcm1_out Gain 0 Switch' 0
amixer -ccherrytrailcrau cset name='codec_in0 Gain 0 Switch' 0
amixer -ccherrytrailcrau cset name='pcm1_out mix 0 codec_in0 Switch' 1
amixer -ccherrytrailcrau cset name='codec_in0 Gain 0 Volume' 0 0
amixer -ccherrytrailcrau cset name='pcm1_out Gain 0 Volume' 0 0
amixer -ccherrytrailcrau cset name='RECMIXL BST2 Switch' 0
amixer -ccherrytrailcrau cset name='RECMIXR BST2 Switch' 0
amixer -ccherrytrailcrau cset name='RECMIXL BST1 Switch' 0
amixer -ccherrytrailcrau cset name='RECMIXR BST1 Switch' 0
amixer -ccherrytrailcrau cset name='Stereo1 DMIC Mux' 'DMIC2'
amixer -ccherrytrailcrau cset name='Stereo1 ADC L2 Mux' 'DMIC'
amixer -ccherrytrailcrau cset name='Stereo1 ADC R2 Mux' 'DMIC'
amixer -ccherrytrailcrau cset name='Sto1 ADC MIXL ADC2 Switch' 1
amixer -ccherrytrailcrau cset name='Sto1 ADC MIXR ADC2 Switch' 1
amixer -ccherrytrailcrau cset name='IF1 ADC1 IN1 Mux' 'IF_ADC1'
amixer -ccherrytrailcrau cset name='IF1 ADC1 IN2 Mux' 'IF1_ADC1_IN1'
amixer -ccherrytrailcrau cset name='DAC1 Playback Volume' 172 172
amixer -ccherrytrailcrau cset name='IN2 Boost Volume' 8
amixer -ccherrytrailcrau cset name='ADC Capture Volume' 50
#amixer -ccherrytrailcrau cset name='IN Capture Volume' 31
#amixer -ccherrytrailcrau cget name='IN Capture Volume' 
#amixer -ccherrytrailcrau cset name='IF2 ADC Mux' 'IF_ADC1'
#amixer -ccherrytrailcrau cset name='Headset Mic Switch' 1
#amixer -ccherrytrailcrau cset name='Int Mic Switch' 1
#amixer -ccherrytrailcrau cset name='IN1 Boost Volume' 6
sleep 1
sudo cp -r cherrytrailcrau /usr/share/alsa/ucm/	
sudo alsactl store cherrytrailcrau
