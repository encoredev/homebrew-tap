class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.1"
    checksums = {
        "darwin_arm64" => "e5bb2c1c766064dacb05a21e48eada0a5170966044df37177bfc47f5c91afefe",
        "darwin_amd64" => "3555595b6d251b5d3eeb188c803dd3407d2c08e37ce9512ba5017e1fbb9a082c",
        "linux_arm64"  => "900c1a696922d7f2ee0a5d005448422ba3a60f4d3646d354371db34016fb96c5",
        "linux_amd64"  => "01b510df8eeacbb767d851f352db137cbb9d3e4100040ede9ca88460968f4fbc",
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

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
