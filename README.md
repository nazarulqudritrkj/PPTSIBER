# 🛡️ SI-CAKRAWALA | Presentation Command Deck (Web PPT)
### Nanggroe Cakrawala Shield — SATSIBER TNI AD

Aplikasi presentasi interaktif berbasis web (*Web-based PowerPoint / Slide Deck*) untuk karya **SI-CAKRAWALA (Nanggroe Cakrawala Shield — TNI AD)**.

- **Live Production Source:** [https://nazarulqudritrkj.github.io/siber/](https://nazarulqudritrkj.github.io/siber/)
- **Proyek Sumber:** `D:\flutter1\siber`
- **Proyek Presentasi:** `D:\flutter1\pptsiber`

---

## 🌟 Fitur Utama Presentasi

1. **Light Theme Prestige UI/UX (Bukan Dark Mode):**
   - Mengusung warna kebangsaan **Merah Putih Indonesia** (`#CC0001` & `#FFFFFF`).
   - Aksen keagungan **Emas Nanggroe Sumatera** (`#D4AF37`) & **Hijau Taktis TNI AD** (`#1A3A28`, `#2D6A4F`).
   - Ornamen geometris halus **Pintu Aceh & Songket Taktis** via `SumateraOrnamentPainter`.
   - Permukaan *Liquid White Glassmorphism* dengan blur dan bias cahaya mutiara.

2. **Kinetic Motion Transitions (Next & Back):**
   - Transisi berarah (*bidirectional 3D parallax depth shift*).
   - Animasi maju (*Next*): slide lama bergerak ke kiri dengan penyusutan lembut, slide baru masuk dari kanan dengan *depth shadow*.
   - Animasi mundur (*Back*): efek *pull-back* dari kiri.
   - Durasi 600ms dengan *Cubic-Bezier Easing* (`Curves.easeOutCubic`) 60 FPS.

3. **Tactical Audio Soundscape:**
   - Suara navigasi maju (*Next SFX*): *High-tech crisp whoosh + affirmative sub-click* (sintesis 440Hz $\to$ 920Hz).
   - Suara navigasi mundur (*Back SFX*): *Reverse resonant harmonic cue* (880Hz $\to$ 380Hz).
   - Suara klik interaktif tombol & terminal (*Click SFX*).
   - Tombol HUD Mute/Unmute instan + shortcut keyboard `M`.

4. **11 Master Slides Deck:**
   - **Slide 01:** Cover Hero & Insignia Garuda Siber Berputar
   - **Slide 02:** Bentang Ancaman Siber Modern & Kedaulatan Digital RI
   - **Slide 03:** Arsitektur Solusi: Nanggroe Cakrawala Shield (Multi-Domain C2)
   - **Slide 04:** Topologi 15 Kodam Nusantara & Konsensus PBFT
   - **Slide 05:** Pilar 1 & 2: Mata Satelit 3D WebGL & Radar Siber 360° Live Sweep
   - **Slide 06:** Pilar 3 & 4: AI Synaptic Threat Engine (98.4%) & Kriptografi Pasca-Kuantum (Kyber-1024)
   - **Slide 07:** Pilar 5 & 6: PBFT Kodam Blockchain & Telemetri Fasilitas Bunker
   - **Slide 08:** Pilar 7 & 8: Operasi Lapangan C2 & Konsol Linux Terminal Interaktif (`satsiber@cakrawala`)
   - **Slide 09:** Live Production Showcase ([nazarulqudritrkj.github.io/siber/](https://nazarulqudritrkj.github.io/siber/))
   - **Slide 10:** Roadmap Strategis Menuju Indonesia Emas 2045
   - **Slide 11:** Kesimpulan Strategis & Sesi Tanya Jawab (Q&A)

5. **Kontrol Presenter:**
   - Keyboard: `Arrow Right` / `Space` / `PageDown` (Lanjut), `Arrow Left` / `PageUp` (Kembali), `Home` (Slide 1), `End` (Slide Terakhir), `M` (Mute/Unmute).
   - Widescreen 16:9 Aspect Ratio Lock otomatis di semua monitor proyektor.
   - Timer presentasi otomatis di header HUD.

---

## 🚀 Cara Menjalankan

### Mode Pengembangan (Local Browser)
```bash
flutter run -d chrome
```

### Build Web Release (Untuk Hosting / GitHub Pages)
```bash
flutter build web --release --web-renderer canvaskit
```
Hasil build akan berada di direktori `build/web/` dan siap diunggah ke GitHub Pages atau server web mana pun.
