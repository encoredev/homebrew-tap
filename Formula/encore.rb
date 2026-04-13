class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.6"
    checksums = {
        "darwin_arm64" => "61d2dc3ec755d0e32c701b2839b0ffa090fc9757341d41ab2791fecc55be55aa",
        "darwin_amd64" => "2027d21405bb96f7a93638d0093a3a01dbc205bcb62e46d771b434ae79f36cfc",
        "linux_arm64"  => "adb4151e508c17ede3b476b386e39d468b5e0661ae5bd02caf216f0dcf3aad44",
        "linux_amd64"  => "eb9a4425b0c710634b36ed451b87688ff53bf594dc03bc4f2df42cfd873d56e4",
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
