use_bpm 60
base = :e3 + 0

live_loop :drums do
  sample :drum_heavy_kick, cutoff: 120, amp: 2.5
  sleep 1/2.0
  sample :drum_heavy_kick, cutoff: 120, amp: 2.5
  sleep 1/2.0
  sample :drum_heavy_kick, cutoff: 120, amp: 2.5
  sleep 1/2.0
  sample :drum_heavy_kick, cutoff: 120, amp: 2.5
  sleep 1/2.0
end

live_loop :harmony do
  with_fx :reverb, mix: 0.8, room: 0.8 do
    with_fx :distortion do
      with_fx :echo, mix: 0.3, phase: 0.125, decay: 1/4.0 do
        use_synth :piano
        play chord(base, :m7, num_octaves: 4),
          release: 3.0, cutoff: 95, amp: 3.0
        sleep 4
      end
    end
  end
end
