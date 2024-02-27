class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.0-nightly.20240227"
    checksums = {
        "darwin_arm64" => "748af79e94ff17038656b3d2bad8f9a8e35dbee93cd2d7448085caec2fe70128",
        "darwin_amd64" => "905c68b2a5878ad24bd8cf40bbd929b057136029d96fe2bd3993d51581edc57f",
        "linux_arm64"  => "4ed422df0910b510c454a15c4b74dd959826c82f82b957cb5fb46b7cbce08a44",
        "linux_amd64"  => "ce9ae437d6380fa1cfb738ddb7555f3ddeba3767f9f7f10a76edc2c6c77cc8cb",
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
