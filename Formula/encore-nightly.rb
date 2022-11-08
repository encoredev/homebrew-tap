class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221108"
    checksums = {
        "darwin_arm64" => "5e68db3b58d0094afd2d8d2b7258d453ccd2373aaa8ef2ebbeef4106ee32567d",
        "darwin_amd64" => "02894e59c5dea7b690f18559163d1ab17ccb3a37d9113906f0d5b6a3942b31d2",
        "linux_arm64"  => "a2ce6065120dadc1edbdceaddd71527656517a07d304545e711aa7b68d78b990",
        "linux_amd64"  => "896ad7bb4e4b65e8d5cad433b55f584942c0273051cd5cc5c71302533786e857",
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
