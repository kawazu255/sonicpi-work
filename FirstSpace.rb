use_bpm 60
base = :e3 + 0

live_loop :drums do
  sample :drum_heavy_kick, cutoff: 120, amp: 2.5
  sleep 1/4.0
  sample :drum_cymbal_closed, rate: 1.2
  sleep 1/4.0
  sample :drum_snare_hard, cutoff: 120, amp: 2.5, rate: 1.2
  sleep 1/4.0
  sample :drum_cymbal_closed, rate: 1.2
  sleep 1/8.0
  if one_in(4)
    sample :drum_snare_hard, cutoff: 120, amp: 2.5, rate: 1.2
    sleep 1/8.0
  else
    sleep 1/8.0
  end
end

live_loop :hihat do
  if one_in(4)
    2.times do
      sample :drum_cymbal_closed, rate: 1.2, amp: 10
      sleep 1/8.0
    end
  else
    sample :drum_cymbal_closed, rate: 1.2
    sleep 1/4.0
  end
  sample :drum_cymbal_open, attack: 0.01, sustain: 0.25, release: 0.25, rate: 1.2
  sleep 0.25
end

live_loop :bass do
  if one_in(8)
    play base, attack: 0, amp: 2, release: 0.5
    sleep 1/8.0
  else
    play base - 12, attack: 0, amp: 2, release: 0.25
    sleep 1/8.0
  end
end

live_loop :harmony do
  with_fx :panslicer, phase: 0.25 do
    use_synth :tb303
    if one_in(4)
      play chord(base, :m7, num_octaves: 4),
        release: 1.0, cutoff: 95, amp: 1.5
      sleep 1
      play chord(base, :m7, num_octaves: 4),
        release: 2.0, cutoff: 95, amp: 1.5
      sleep 3
    else
      play chord(base, :m7, num_octaves: 4),
        release: 3.0, cutoff: 95, amp: 1.5
      sleep 4
    end
  end
end

arpeggio=(ring 0,1,2,1,3,2,1,2)

live_loop :arpeggio do
  with_fx :reverb, room:0.9 do
    use_synth :square
    c=[base + 12,:M]
    for i in 0...c.length/2
      8.times do
        play chord(c[i*2],c[i*2+1],num_octaves:2)[arpeggio.choose], amp: 1.2, release: 0.1
        sleep 0.125
      end
    end
  end
end
