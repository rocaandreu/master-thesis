import numpy as np
import matplotlib.pyplot as plt

# ============================================================
# Burst Size / Flow Distribution Sweep
# ============================================================

cases = [
    "1-packet bursts\nSequential flows\n",
    "32-packet bursts\nSequential flows\n",
    "Random burst length\nRandom flow order\n"
]

# Latency [ns]
max_latency = [349624, 2792, 179776]
min_latency = [2196, 2012, 2120]
avg_latency = [116415, 2358, 37616]

# Throughput [Gb/s]
throughput = [79.069718, 102.953770, 96.197458]

x = np.arange(len(cases))

# ============================================================
# Create figure
# ============================================================

fig, ax1 = plt.subplots(figsize=(11, 6))

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
    "Burst Size / Flow Distribution",
    fontsize=12
)

ax1.set_ylabel(
    "Latency (ns)",
    fontsize=12
)

ax1.set_xticks(x)
ax1.set_xticklabels(cases, fontsize=10)

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
    "Packet Buffer Performance vs. Burst Size and Flow Distribution",
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
#     "burst_size_flow_distribution_sweep.pdf",
#     bbox_inches="tight"
# )

# PNG
# plt.savefig(
#     "burst_size_flow_distribution_sweep.png",
#     dpi=300,
#     bbox_inches="tight"
# )
