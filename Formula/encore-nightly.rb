class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0-nightly.20231126"
    checksums = {
        "darwin_arm64" => "104d47cfab9c72bb6e85c17fa21d381b403077bbd33b2134e36a93e60313651d",
        "darwin_amd64" => "71bb95f8e84306736e08494b52b21db309e5cb6ad870722f80f40370931bf064",
        "linux_arm64"  => "edfb93556a8880fa4789e937f61ee741867711bfe5fb836829862d6a579f6674",
        "linux_amd64"  => "0dcf092356c93d46d5cb73f0db3d061c3efbfc76f120351ec5f601da53f1ff70",
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
