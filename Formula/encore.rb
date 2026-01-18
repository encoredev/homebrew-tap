class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.53.7"
    checksums = {
        "darwin_arm64" => "153c45a654ac521f628e93efcd3434b1cae1a3538791fdae283f36852270fd5d",
        "darwin_amd64" => "2ad3a20b525d0f15a6c3123a885cb2886dff74b85a18e1edfde991a951c91330",
        "linux_arm64"  => "09cff75cf3d44591415d3455002909136ae90adcfa26f55fcc81a76b0ca86fd7",
        "linux_amd64"  => "6edc0182c4391189d1125b06d4f7c8a2ef3b5d0c04e2f47b1e5f663bca449483",
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
