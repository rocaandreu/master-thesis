import numpy as np
import matplotlib.pyplot as plt

# ============================================================
# Packet Size Sweep Results
# ============================================================

cases = [
    "Randomized\n(Uniform)",
    "Maximum\n(1500 B)",
    "Minimum\n(46 B)"
]

# Latency [ns]
max_latency = [2576, 3732, 624]
min_latency = [2000, 3552, 592]
avg_latency = [2289, 3640, 608]

# Throughput [Gb/s]
throughput = [106.422691, 112.833983, 92.910906]

x = np.arange(len(cases))

# ============================================================
# Create figure
# ============================================================

fig, ax1 = plt.subplots(figsize=(10, 6))

# ----------------------------
# Latency bars
# ----------------------------

width = 0.22

bars_min = ax1.bar(
    x - width,
    min_latency,
    width,
    label="Min Latency",
)

bars_avg = ax1.bar(
    x,
    avg_latency,
    width,
    label="Avg Latency",
)

bars_max = ax1.bar(
    x + width,
    max_latency,
    width,
    label="Max Latency",
)

ax1.set_xlabel(
    "Packet Size Configuration",
    fontsize=12
)

ax1.set_ylabel(
    "Latency (ns)",
    fontsize=12
)

ax1.set_xticks(x)
ax1.set_xticklabels(cases, fontsize=11)

ax1.grid(
    axis="y",
    linestyle="--",
    alpha=0.4
)

# ============================================================
# Add values above latency bars
# ============================================================

def add_bar_labels(bars):
    for bar in bars:
        height = bar.get_height()

        ax1.annotate(
            f"{height:,.0f}",
            xy=(
                bar.get_x() + bar.get_width() / 2,
                height
            ),
            xytext=(0, 5),
            textcoords="offset points",
            ha="center",
            va="bottom",
            fontsize=9,
        )


add_bar_labels(bars_min)
add_bar_labels(bars_avg)
add_bar_labels(bars_max)

# ============================================================
# Throughput
# ============================================================

ax2 = ax1.twinx()

ax2.plot(
    x,
    throughput,
    marker="o",
    linewidth=2.5,
    markersize=8,
    label="Throughput",
)

ax2.set_ylabel(
    "Throughput (Gb/s)",
    fontsize=12
)

# Make throughput axis start at 0
ax2.set_ylim(bottom=0, top=120)

# ============================================================
# Add throughput values above points
# ============================================================

for i, value in enumerate(throughput):
    ax2.annotate(
        f"{value:.2f}",
        xy=(x[i], value),
        xytext=(0, 8),
        textcoords="offset points",
        ha="center",
        va="bottom",
        fontsize=9,
    )

# ============================================================
# Combined legend
# ============================================================

handles1, labels1 = ax1.get_legend_handles_labels()
handles2, labels2 = ax2.get_legend_handles_labels()

ax1.legend(
    handles1 + handles2,
    labels1 + labels2,
    loc="upper left",
    frameon=True,
)

# ============================================================
# Formatting
# ============================================================

ax1.set_title(
    "Packet Buffer Performance vs. Packet Size",
    fontsize=14,
    fontweight="bold",
)

fig.tight_layout()

# ============================================================
# Display
# ============================================================

plt.show()

# ============================================================
# Save for thesis
# ============================================================

# PDF - recommended
# plt.savefig(
#     "packet_size_sweep.pdf",
#     bbox_inches="tight"
# )

# PNG
# plt.savefig(
#     "packet_size_sweep.png",
#     dpi=300,
#     bbox_inches="tight"
# )
