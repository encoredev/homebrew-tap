class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0-nightly.20231212"
    checksums = {
        "darwin_arm64" => "2b0c17493e5a76a12ab67b3cc9d2e0bf4e27e956446f85c20d32783521d97609",
        "darwin_amd64" => "8e49f627b85d9487f226229f1e3645fbeeea39533a8fbae4f950266359efe341",
        "linux_arm64"  => "b117776ff5c76e9f4cfdb08fdc24cc4235ce21d23092b701300b2cfab51e06e5",
        "linux_amd64"  => "2c0d598430a8dcaeb0501e7bb60b715c1a14a30ab6961f12c7d560e37ec395bb",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end
