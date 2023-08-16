class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230816"
    checksums = {
        "darwin_arm64" => "f8ac004604ef02c6e39666e8f1e9b62271c50c3317b274bcaca251c4508f7f4d",
        "darwin_amd64" => "29c8f1b42e2d74e2bf0d388770414b8803df521819275c22d39272bed13011d3",
        "linux_arm64"  => "b582744ed52923e582e3933cc124278d55c166ca23b5bfcb49627fe468332336",
        "linux_amd64"  => "a92147008bf9492e8d2438929a6658573bac6697c6382e5a6c050db302821b4c",
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
