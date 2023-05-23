class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230523"
    checksums = {
        "darwin_arm64" => "eeccfcc4dc16d9189dd4231938e29b60e9c9b506507a632ad78573d84fed54c3",
        "darwin_amd64" => "da0ea68f963c81c89ab657fe1d17839f744be7c1341e36f0cc8e4064a431be74",
        "linux_arm64"  => "c29381ba0bcb9a14aea233f314f744da2e07dc7843b8f2e38420c5cab8a1fa06",
        "linux_amd64"  => "9241ee31dcc3bfdff729f94b03dac901d87241f3d589724215b36ad524214567",
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
